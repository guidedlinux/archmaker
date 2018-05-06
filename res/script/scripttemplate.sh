#!/bin/bash
if [ "$EUID" = 0 ]; then
  echo "Please don't run this script as root!"
  exit
fi
distroversion=""
distrocodename=""
echo "Welcome to the generation script for 'DISTNAME'"
echo "==========="
if [ "$1" != "" ]; then
  distroversion="$1"
  distrocodename="$2"
else
  echo -n "Please enter the current version of 'DISTNAME' > "
  read distroversion
  echo -n "Please enter the current codename of 'DISTNAME' > "
  read distrocodename
fi
createdir() {
  sudo mkdir workingdir
  sudo cp -r /usr/share/archiso/configs/releng/* ./workingdir
}
copypackages() {
  sudo cp ./packages ./workingdir/packages.both
}
copyskel() {
  sudo mkdir ./workingdir/airootfs/etc/skel
  sudo cp -r ./skeldata/* ./workingdir/airootfs/etc/skel/
  GUILOGIN
}
createlsbrelease() {
  echo "lsb-release" | sudo tee --append ./workingdir/packages.both > /dev/null
  echo "DISTRIB_ID=DISTNAME" | sudo tee ./workingdir/airootfs/etc/lsb-release > /dev/null
  echo 'DISTRIB_DESCRIPTION="DISTDESCR"' | sudo tee --append ./workingdir/airootfs/etc/lsb-release > /dev/null
  echo "DISTRIB_RELEASE=$distroversion" | sudo tee --append ./workingdir/airootfs/etc/lsb-release > /dev/null
  echo "DISTRIB_CODENAME=$distrocodename" | sudo tee --append ./workingdir/airootfs/etc/lsb-release > /dev/null
}
compilecalamares() {
  echo "Preparing Repository..."
  mkdir customrepo
  mkdir customrepo/x86_64
  mkdir customrepo/i686
  mkdir customrepo/archmaker-calamares
  echo "Preparing Calamares-build..."
  curl http://archmaker.guidedlinux.org/PKGBUILD > customrepo/archmaker-calamares/PKGBUILD
  FILES="calamaresslides/*"
  currentslide=1
  for f in $FILES
  do
  currentline=$(( $currentslide + 27 ))
  sed -i "${currentline}a\ \ \ \ cp $(pwd)\/$f src\/branding\/custombranding\/" ./customrepo/archmaker-calamares/PKGBUILD
  echo "    echo '    ' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '    Slide {' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '        ' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '        Image {' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '            id: background${currentslide}' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '            source: \"${f##*/}\"' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '            width: 800; height: 440' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '            fillMode: Image.PreserveAspectFit' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '            anchors.centerIn: parent' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '        }' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '    }' >> src/branding/custombranding/show.qml" >> slideshowchanges
  currentslide=$(( $currentslide + 1 ))
  done
  sed -i "s/DISTRNAME/'DISTNAME'/g" ./customrepo/archmaker-calamares/PKGBUILD
  sed -i "s/DISTRVERSION/${distroversion}/g" ./customrepo/archmaker-calamares/PKGBUILD
  echo "    echo '    ' >> src/branding/custombranding/show.qml" >> slideshowchanges
  echo "    echo '}' >> src/branding/custombranding/show.qml" >> slideshowchanges
  lastline=$(( $currentslide + 27 ))
  sed -i '/mkdir -p build/r slideshowchanges' ./customrepo/archmaker-calamares/PKGBUILD
  rm slideshowchanges
  cd ./customrepo/archmaker-calamares
  makepkg --printsrcinfo > .SRCINFO
  cd ../
  echo "Building qt5-styleplugins-git..."
  git clone https://aur.archlinux.org/qt5-styleplugins-git.git
  cd qt5-styleplugins-git
  makepkg -si
  cp *.pkg.ta* ../x86_64
  cd ../
  echo "Building calamares..."
  cd archmaker-calamares
  makepkg -s
  cp *.pkg.ta* ../x86_64
  cd ../
  rm -rf qt5-styleplugins-git archmaker-calamares
  cd ../
  echo "archmaker-calamares" | sudo tee --append ./workingdir/packages.both > /dev/null
}
compileaurpkgs() {
  mkdir customrepo/custompkgs
  repopath="$(readlink -f .)"
  buildingpath="$(readlink -f ./customrepo/custompkgs)"
  while IFS='' read -r currentpkg || [[ -n "$currentpkg" ]]; do
    cd customrepo/custompkgs
    curl $currentpkg > ./currentpkg.tar.gz
    tar xf currentpkg.tar.gz
    rm currentpkg.tar.gz
    for d in */ ; do
      cd "$d"
    done
    makepkg -s
    cp *.pkg.ta* ../../x86_64
    cd $buildingpath
    for d in */ ; do
      rm -rf "$d"
    done
    cd $repopath
  done < "aurpackages"
  rm -rf customrepo/custompkgs
  unset repopath buildingpath
}
setuprepo() {
  cd customrepo/x86_64
  echo "Adding packages to repository..."
  repo-add customrepo.db.tar.gz *.pkg.ta*
  cd ../..
  echo "[customrepo]" | sudo tee --append ./workingdir/pacman.conf > /dev/null
  echo "SigLevel = Never" | sudo tee --append ./workingdir/pacman.conf > /dev/null
  echo "Server = file://$(pwd)/customrepo/$(echo '$arch')" | sudo tee --append ./workingdir/pacman.conf > /dev/null
  sudo pacman -Syy
  cat /etc/pacman.conf > ./pacman.backup
  echo "[customrepo]" | sudo tee --append /etc/pacman.conf > /dev/null
  echo "SigLevel = Never" | sudo tee --append /etc/pacman.conf > /dev/null
  echo "Server = file://$(pwd)/customrepo/$(echo '$arch')" | sudo tee --append /etc/pacman.conf > /dev/null
  sudo pacman -Syy
}
buildtheiso() {
  sudo rm -rf ./workingdir/airootfs/etc/systemd/system/getty*
  cd workingdir
  sudo ./build.sh -v
  cd ../
}
cleanup() {
  echo "Cleaning up..."
  cat ./pacman.backup | sudo tee /etc/pacman.conf > /dev/null
  sudo pacman -Syy
  rm ./pacman.backup
  sudo rm -rf /var/cache/pacman/pkg/archmaker-calamares*
  sudo rm -rf /var/cache/pacman/pkg/qt5-styleplugins-git*
  finalfiles=""
  while IFS='' read -r currentpkg || [[ -n "$currentpkg" ]]; do
    finalfiles="$finalfiles /var/cache/pacman/pkg/$(cut -d'.' -f1 <<<"${currentpkg##*/}")*"
  done < "aurpackages"
  echo "Deleting files $finalfiles..."
  sudo rm -rf $finalfiles
  rm -rf ./customrepo
  echo "Saving iso file..."
  cp ./workingdir/out/*.iso ./output.iso
  echo "Removing archiso directory..."
  sudo rm -rf workingdir
}
createdir
copypackages
copyskel
createlsbrelease
compilecalamares
compileaurpkgs
setuprepo
buildtheiso
cleanup
