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
          sh "docker build -t parcelservice-proxy ."
      }
      else
      {
          //Remove the previous build image
          bat "docker rmi parcelservice-proxy"
          bat "docker build -t parcelservice-proxy ."
      }

   }
   stage('Deploy Image to Asset-Server')
   {
      sh "docker save parcelservice-proxy > proxy.tar"
      sh "sshpass -p 'vagrant' scp -o StrictHostKeyChecking=no proxy.tar vagrant@192.168.56.100:/home/vagrant/images"
   }
   stage('Start LoadBalancer')
   {
      sh " docker run -d -p 80:80 --restart always --network=ParcelService --name=proxy parcelservice-proxy"
   }
}
