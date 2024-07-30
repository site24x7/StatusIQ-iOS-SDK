# StatusIQ-iOS-SDK

Mobile applications help business services ensure a continuous interaction with customers and enable customers to access their services anytime, from any location. But when availability issues strike, the user experience is often hampered. By providing timely updates regarding the outage or the recovery process, customers are kept in the loop thereby making the process transparent.

With a public status page, like StatusIQ, you can post real-time updates to keep your customers updated on your active incidents or scheduled maintenance, publish postmortem reports, and more. Integrate your mobile applications with StatusIQ and help users track service status updates. 

The StatusIQ iOS SDK (StatusIQFramework) is a free module for StatusIQ. The perk is that you can integrate the StatusIQ iOS SDK with your business's mobile iOS app and showcase the service's availability. We've created a Status iOS Pod which contains the StatusIQ iOS framework. Businesses using the StatusIQ product can now integrate the Status iOS Pod in their business apps to showcase their real-time service status to clients. The integration is supported for the dark theme and provides various customization options, like changing the font, color customization, and navigation.   

Follow these steps to integrate the StatusIQ iOS pod into your business app:

1. Open your business app in Xcode. 
2. Add the repository source URL and pod name with your respective target to the pod file.
For instance, pod 'StatusIQ', :source=> https://github.com/site24x7/StatusIQ-iOS-SDK.git

	<img width="366" alt="11d3fa93-f1c6-4fcf-bad8-4b8be62d0063" src="https://github.com/user-attachments/assets/65526548-5de6-4a80-a648-54b7c039d986">

3. After adding the pod, navigate to the StatusIQInfo.plist file and under Status page url, provide your StatusIQ public page URL that you would like to showcase in the business app. If you wish to list the components you have on your StatusIQ page as your components in the business app, then, in the .plist file, set Show Component status alone to True. Provide the component of your preference in the field Component Name.

	 <img width="660" alt="Screenshot 2024-07-30 at 11 44 10 AM" src="https://github.com/user-attachments/assets/71508815-6ada-43a2-bf9a-c88ad26bf595">


4. Based on the requirements of your business app, you can add the Tap button wherever required to showcase the status.
5. After adding the Tap button, you can import the StatusIQ Framework and implement the code below into the Tap button code definition.

####
	let statusIQVC = StatusIQServiceStatus.sdkInit()
	self.present(statusIQVC, animated: true, completion: nil)

Screens are available in both light and dark modes for enhanced visibility.
### The Light Mode
	
<img width="300" alt="Servie_status_active_Incidents" src="https://github.com/user-attachments/assets/cbcc0e28-4dbb-43f5-b96a-201bbef5b464"> &nbsp;&nbsp;&nbsp;
<img width="300" alt="Service_status_Component_alone" src="https://github.com/user-attachments/assets/b6669a2b-c7cb-41f3-8034-127b0371e786">

<img width="300" alt="Service_status_Incident_history" src="https://github.com/user-attachments/assets/a7db74e9-91b9-4518-97ab-1b7d9eef7feb">&nbsp;&nbsp;&nbsp;
<img width="300" alt="Service_status_Component_Summary" src="https://github.com/user-attachments/assets/56734a10-617e-4ce5-984e-1709d2a474a2">&nbsp;&nbsp;&nbsp;

### The Dark Mode

<img width="300" alt="Servie_status_active_Incidents_dark" src="https://github.com/user-attachments/assets/77a03f9e-32b4-4cb5-9a96-8cb498672755">
<img width="300" alt="Service_status_Component_alone_dark" src="https://github.com/user-attachments/assets/626ea30c-5ac1-4542-a631-a5a6c75f4710">&nbsp;&nbsp;&nbsp;


## How to customize the StatusIQ framework 


### Color customization

You can customize the StatusIQ Framework UI/UX to suit your application theme. To customize, open the StatusIQ Framework in Xcode and find the class StatusIQCustomization, which provides methods to change the theme of the StatusIQ Framework.

Use the following method to set the desired background color that is already used in your app. The method argument to pass the desired color is the UIColor value:

#### StatusIQCustomization.setBackgroundColor(bgColor : )
	
Use the following method to change the background color of the Navigation Bar. The method argument to pass the desired UIColor value is:

#### StatusIQCustomization.setNavigationBarBackgroundColor(barColor : )

### Font customization
	
Use the following method to set the desired font style that is already used in your app. The method argument to pass the font name is the String type:

#### StatusIQCustomization.setFontName(fontName : )

	Font name = Trebuchet MS
	Background color = UIColor.white
	Navigation Bar color = UIColor.gray
