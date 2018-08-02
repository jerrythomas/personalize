VENV=`pipenv --venv`
VERSION=`ls $VENV/lib/ | grep python`
ORIG=`brew ls opencv3 | grep $VERSION | grep site-packages`
ln -s $ORIG $VENV/lib/$VERSION/site-packages/cv2.so
