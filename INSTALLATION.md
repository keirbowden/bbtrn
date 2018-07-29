# Installation

The easiest way to install is via the Salesforce CLI installation script. This will install an unmanaged package containing the configuration metadata, custom metadata records for the app and example remote endpoint configuration and remote site for the example endpoint, and a further unmanaged package containing the application itself.

On MacOS, after cloning the repository, execute the sfdx_install.sh bash script.:

```$ ./sfdx_install.sh MINDEPLOY
Waiting for the package install request to complete. Status = IN_PROGRESS
Waiting for the package install request to complete. Status = IN_PROGRESS
Successfully installed package [04t0O0000018QDM]
Waiting for the package install request to complete. Status = IN_PROGRESS
Waiting for the package install request to complete. Status = IN_PROGRESS
Waiting for the package install request to complete. Status = IN_PROGRESS
Successfully installed package [04t0O000001IqIw]
Activate the 'Training' flexipage to try out the training system.
```

Once this is complete, follow the final instruction to activate the Training flexipage:

Navigate to Setup -> Lightning App Builder:

![App Builder Link](https://i.imgur.com/g8Fl4Bz.png)

Click the 'Edit' link next to the Training entry:

![List of FlexiPages](https://i.imgur.com/yNfQPxr.png)

Click the activation button at the top right of the screen:

![Activation Button](https://i.imgur.com/OWgP4s2.png)

Select Lightning Experience and add the page to the desired applications:

![Activation Page](https://i.imgur.com/ywngNJy.png)

Click Save once done.

You can then access the training page via the waffle menu, searching for 'Training' and clicking the resulting link.
