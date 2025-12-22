#!/bin/bash

ACTION=$1
ARG=$2

PROJECT_NAME="spring3hibernate"
WAR_FILE="target/${PROJECT_NAME}.war"
TOMCAT_WEBAPPS="/opt/tomcat/webapps"

usage() {
    echo "Usage:"
    echo "./buildMaven.sh -a               Generate artifact"
    echo "./buildMaven.sh -i               Install artifact to local repo"
    echo "./buildMaven.sh -s <tool>        Static analysis (checkstyle|findbugs|pmd)"
    echo "./buildMaven.sh -t               Unit test + coverage"
    echo "./buildMaven.sh -d               Deploy to Tomcat"
    exit 1
}

case $ACTION in

-a)
    echo "Generating artifact..."
    mvn clean package
    ;;

-i)
    echo "Installing artifact to local repo..."
    mvn clean install
    ;;

-s)
    if [ -z "$ARG" ]; then
        echo "Static analysis tool required"
        exit 1
    fi

    case $ARG in
        checkstyle)
            mvn checkstyle:check
            ;;
        findbugs)
            mvn findbugs:check
            ;;
        pmd)
            mvn pmd:check
            ;;
        *)
            echo "Invalid static analysis tool"
            exit 1
            ;;
    esac
    ;;

-t)
    echo "Running unit tests & coverage..."
    mvn test jacoco:report
    ;;

-d)
    echo "Deploying to Tomcat..."
    if [ ! -f "$WAR_FILE" ]; then
        echo "WAR not found. Build first."
        exit 1
    fi
    cp $WAR_FILE $TOMCAT_WEBAPPS/
    echo "Deployment successful"
    ;;

*)
    usage
    ;;
esac
