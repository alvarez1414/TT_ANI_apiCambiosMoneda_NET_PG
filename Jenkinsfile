pipeline{
    agent any

    environment{
        DOCKER_IMAGE= 'apicambiosmodenas_net'
        CONTAINER_NAME='dockerapicambiosmodenas_net'
        APP_PORT='5235'
        HOST_PORT='7080' // Cambia si quieres mapear a otro puerto en la maquina
        DOCKER_NETWORK='dockermodenas_red' // Red compartida con Postgres
    }

    stages {

        stage('Ejecutar pruebas unitarias') {
            steps {
                script {
                    bat "dotnet test apiCambiosMoneda.Test\\apiCambiosMoneda.Test.csproj --configuration Release"
                }
            }
        }
        stage('Construir Imagen Docker'){
            steps{
                bat "docker build -t %${DOCKER_IMAGE}% ."
            }
        }
        stage('Limpiar contenedor existente'){
            steps{
                bat "docker rm -f ${CONTAINER_NAME} || exit 0"
            }
        }        
        stage('Desplegar Contener'){
            steps{
                bat "docker run --network ${DOCKER_NETWORK} --name ${CONTAINER_NAME} -p ${HOST_PORT}:${APP_PORT} -d ${DOCKER_IMAGE}"
            }
        }
    }

}