#! /bin/sh

RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NO_COLOR='\033[0m'

while getopts ":e:o:t:" opt; do
  case $opt in
    e) APP_ENV="$OPTARG"
    ;;
    o) APP_OS="$OPTARG"
    ;;
    t) DEPLOY_TYPE="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

APP_ENV=${APP_ENV:-"staging"}
APP_OS=${APP_OS:-"ios and android"}
DEPLOY_TYPE=${DEPLOY_TYPE:-"soft"}

if [ $DEPLOY_TYPE == "hard" ]; then
  echo "${BLUE}* * * * *"
  echo "👷  Hard-Deploy"
  echo "* * * * *${NO_COLOR}"
  read -r -p "Did you bump the versions in fastlane/.env [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY])
    if [[ $APP_OS != "android" ]]; then
      echo "${GREEN}- - - - -"
      echo "Fastlane 🍎  iOS $APP_ENV"
      echo "- - - - -${NO_COLOR}"
      bundle exec fastlane ios deploy --env=$APP_ENV
    fi
    if [[ $APP_OS != "ios" ]]; then
      echo "${YELLOW}- - - - -"
      echo "Fastlane 🤖  Android $APP_ENV"
      echo "- - - - -${NO_COLOR}"
      bundle exec fastlane android deploy --env=$APP_ENV
    fi
    ;;
  esac
fi

if [ $DEPLOY_TYPE == "soft" ]; then
  echo "${CYAN}* * * * *"
  echo "🍦  Soft-Deploy"
  echo "* * * * *${NO_COLOR}"
  git stash
  git checkout integration
  git pull
  source fastlane/.env
  MESSAGE=$(git log HEAD --pretty=format:"%h : %s" -1)
  echo "${CYAN}Deploying Commit : $MESSAGE${NO_COLOR}"
  yarn
  if [ $APP_ENV == "production" ]; then
    echo "- - - - -"
    echo "️️️⚠️  No Codepush for Production yet"
    echo "- - - - -"
  else
    if [[ $APP_OS != "android" ]]; then
      echo "${GREEN}- - - - -"
      echo "Codepush 🍎  iOS Staging"
      echo "- - - - -${NO_COLOR}"
      code-push release-react -d Staging investo-ios ios -m --targetBinaryVersion $IOS_VERSION --des "$MESSAGE"
    fi
    if [[ $APP_OS != "ios" ]]; then
      echo "${YELLOW}- - - - -"
      echo "Codepush 🤖  Android Staging"
      echo "- - - - -${NO_COLOR}"
      code-push release-react -d Staging investo-android android -m --targetBinaryVersion $ANDROID_VERSION_NAME --des "$MESSAGE"
    fi
  fi
fi
