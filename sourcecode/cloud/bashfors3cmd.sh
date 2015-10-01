//bash code to install s3cmd 
mkdir s3downloads
cd s3downloads
wget http://sourceforge.net/projects/s3tools/files/s3cmd/1.0.0/s3cmd-1.0.0.zip
unzip s3*zip
cd s3* 
python2.6 setup.py install --user
mkdir ~/bin
cp s3cmd ~/bin
cp -R S3 ~/bin
cd
rm -r s3downloads
