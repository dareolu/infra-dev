Documentation

1. Create folder 

-- create folder called REPOSITORY in infra-dev/vagrant/Barclays/CLOUDERA_PROJECT
-- create folder structure  "/_cm5-repo/cloudera-cm5.7.2-centos6/" inside REPOSITORY Folder
-- create folder _cdh5-parcels inside REPOSITORY Folder

2. Download Cloudera Manager Repo from Archive CM, select the version of your choice, and OS type, and place the repo inside "cloudera-cm5.7.2-centos6"
3. Extract the REPO. It will create "cm" directory (I used 7zip to extract the file in case you dont already have a tool to extract in windows. by the way i did it twice.)
4. Similarly, as we downloaded CM, download CDH from Archive, but use Parcels as it is more compressed. Select your prefered version and distribution. Also download the manifest.json file
5. Extract the parcels and put the manifest.json file into _cdh5-parcels folder created above


-----------------------------------------------------------------------------------------------|
vagrant package --base templateMasterNode  --output CDHMaster.box                              |
vagrant package --base templateSlaveNode --output CDHSlave.box                                 |
                                                                                               |
vagrant box add  templateMasterNode file:///E:/Barclays/VAGRANT_PROJECT/CDHMaster.box          |    
vagrant box add  templateSlaveNode file:///E:/Barclays/VAGRANT_PROJECT/CDHSlave.box            |
-----------------------------------------------------------------------------------------------|






