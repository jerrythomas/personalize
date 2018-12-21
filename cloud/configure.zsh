#!/bin/zsh

# uncomment #host for kibana in the yml file

function enable_kibana() {
    if [ $# -eq 1 ]; then
        SERVICE=$1
        KIBANA="host: \"localhost:5601\""
        #YMLCONFIG=`brew list $SERVICE | grep $SERVICE.yml`
        YMLCONFIG=/usr/local/etc/$SERVICE/$SERVICE.yml

        sed -i.bak "s/#$KIBANA/$KIBANA/g" "$YMLCONFIG"
        brew services start $SERVICE
    else
      echo "Usage: enable_kibana <service_name>"
    fi
}
