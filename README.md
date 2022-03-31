# StatusIQ-iOS-SDK

Mobile applications help business services ensure a continuous interaction with customers and enable customers to access their services anytime, from any location. But when availability issues strike, the user experience is often hampered. By providing timely updates regarding the outage or the recovery process, customers are kept in the loop thereby making the process transparent.

With a public status page, like StatusIQ, you can post real-time updates to keep your customers updated on your active incidents or scheduled maintenance, publish postmortem reports, and more. Integrate your mobile applications with StatusIQ and help users track service status updates. 

The StatusIQ iOS SDK (StatusIQFramework) is a free module for StatusIQ. The perk is that you can integrate the StatusIQ iOS SDK with your business's mobile iOS app and showcase the service's availability. We've created a Status iOS Pod which contains the StatusIQ iOS framework. Businesses using the StatusIQ product can now integrate the Status iOS Pod in their business apps to showcase their real-time service status to clients. The integration also provides various customization options, like changing the font, color customization, and navigation.

Follow these steps to integrate the StatusIQ iOS pod into your business app:

1. Open your business app in Xcode. 
2. Add the repository source URL and pod name with your respective target to the pod file.
For instance, pod 'StatusIQ', :source=> https://github.com/site24x7/StatusIQ-iOS-SDK.git

	<img width="366" alt="11d3fa93-f1c6-4fcf-bad8-4b8be62d0063" src="https://user-images.githubusercontent.com/6861082/116873005-93a0d500-ac34-11eb-9360-5c162366e325.png">

3. After adding the pod, navigate to the StatusIQInfo.plist file and under Status page url, provide your StatusIQ public page URL that you would like to showcase in the business app. If you wish to list the components you have on your StatusIQ page as your components in the business app, then, in the .plist file, set Show Component status alone to True. Provide the component of your preference in the field Component Name.

	<img width="550" alt="8923e1f5-e860-4be4-b73c-024608e01871" src="https://user-images.githubusercontent.com/6861082/116873587-9223dc80-ac35-11eb-8b03-9c77be23b207.png">

4. Based on the requirements of your business app, you can add the Tap button wherever required to showcase the status.
5. After adding the Tap button, you can import the StatusIQ Framework and implement the code below into the Tap button code definition.

####
	let statusIQVC = StatusIQServiceStatus.sdkInit()
	self.present(statusIQVC, animated: true, completion: nil)

	
<img width="300" alt="Servie_status_active_Incidents" src="https://user-images.githubusercontent.com/98751716/161042665-5f9942d1-238d-46af-919a-4f2da47f3c60.png"> &nbsp;&nbsp;&nbsp;
<img width="300" alt="Service_status_Component_Summary" src="https://user-images.githubusercontent.com/98751716/161042682-bc4fc877-933b-4a30-8383-0d21e906de31.png">&nbsp;&nbsp;&nbsp;

<img width="300" alt="Service_status_Incident_history" src="https://user-images.githubusercontent.com/98751716/161053083-56e7d004-29d9-4ddc-b191-dd919b3f9753.png">&nbsp;&nbsp;&nbsp;
<img width="300" alt="Service_status_Component_alone" src="https://user-images.githubusercontent.com/98751716/161042842-d5bdbcc5-6635-4a2f-abee-ccea7d8c498d.png">


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
