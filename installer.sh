#! /bin/bash
# A simple script to install or uninstall dillinger as a service
service=`launchctl list | grep dillinger`
if [ -z "$1" ]; then
  echo "installer [install|uninstall]"
else
  if [ "$1" == "install" ]; then
    if [ -z "$service" ]; then
      echo "Installing service..."
      launchctl load org.jack.dillinger.plist
      echo "Add the following to your .bashrc and then source it:"
        echo "dillinger_start() {"
        echo "  service=`launchctl list | grep org.jack.dillinger | grep ^-`"
        echo "  if [ ! -z "$service" ]; then"
        echo "    launchctl start org.jack.dillinger"
        echo "  fi"
        echo "  open http://localhost:8080"
        echo "}"
        echo "dillinger_stop() {"
        echo "  service=`launchctl list | grep org.jack.dillinger | grep ^-`"
        echo "  if [ -z "$service" ]; then"
        echo "    launchctl stop org.jack.dillinger"
        echo "  fi"
        echo "}"
    else
      echo "Service already installed: $service"
    fi
  elif [ "$1" == "uninstall" ]; then
    if [ -z "$service" ]; then
      echo "Service not installed."
    else
      echo "Uninstalling service."
      launchctl unload org.jack.dillinger.plist
    fi
  fi
fi
