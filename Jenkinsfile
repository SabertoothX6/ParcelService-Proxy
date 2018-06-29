node {
   stage('Preparation')
   { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/sabertoothx6/ParcelService-Proxy.git'
   }
   stage('Build Docker Image')
   {
      if(isUnix())
      {
          //Create Variable that holds the info if docker image exists
          IMAGE_EXISTS = sh(
          script: "docker images -q parcelservice-proxy",
          returnStatus : true)
          //Remove the previous build image if it was build before
          if(IMAGE_EXISTS!="")
          {
              sh "docker rmi -f parcelservice-proxy"
          }
          //Build new container with image parcelservice-proxy
          sh "docker build -t parcelservice-proxy:${currentBuild.number} ."
      }
      else
      {
          //Remove the previous build image
          bat "docker rmi parcelservice-proxy"
          bat "docker build -t parcelservice-proxy:${currentBuild.number} ."
      }

   }
   stage('Deploy Image to Asset-Server')
   {
      sh "docker save parcelservice-proxy:${currentBuild.number} > proxy.${currentBuild.number}.tar"
      sh "sshpass -p 'vagrant' scp -o StrictHostKeyChecking=no proxy.${currentBuild.number}.tar vagrant@192.168.56.100:/home/vagrant/images"
   }
   /*stage('Start LoadBalancer')
   {
      sh "docker rm -f proxy"
      sh "docker run -d -p 80:80 --restart always --network=host --name=proxy parcelservice-proxy"
   }*/
}
