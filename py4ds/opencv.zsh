update='false'
while getopts 'ue:' flag; do
  case "${flag}" in
    u) update='true' ;;
    e) VENV_NAME=${OPTARG};
       VIRTUAL_ENV="${HOME}/Applications/${OPTARG}" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

if [ ${update} = 'true' ]  && [ -f $VIRTUAL_ENV/bin/activate ]
then
    source $VIRTUAL_ENV/bin/activate
    pip freeze > $HOME/${VENV_NAME}_requirements.txt
    deactivate
    rm -rf $VIRTUAL_ENV

    virtualenv -p python3 $VIRTUAL_ENV
    source $VIRTUAL_ENV/bin/activate
    pip install -r $HOME/${VENV_NAME}_requirements.txt
    deactivate
fi

PKGBASE=`brew ls opencv3 | grep python3 | grep site-packages | cut -f1-9 -d/ | uniq`
ORIG=`brew ls opencv3 | grep python3 | grep site-packages | grep darwin`
#ln -s $ORIG $PKGBASE/cv2.so

PYBASE=`ls $VIRTUAL_ENV/lib/`
ln -s $ORIG $VIRTUAL_ENV/lib/$PYBASE/site-packages/cv2.so

# numpy is required for opencv3
source $VIRTUAL_ENV/bin/activate
pip install numpy
