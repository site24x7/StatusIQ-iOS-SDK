# StatusIQ-iOS-SDK
Mobile applications help business services ensure a continuous interaction with customers and enable customers to access their services anytime, from any location. But when availability issues strike, the user experience is often hampered. By providing timely updates regarding the outage or the recovery process, customers are kept in the loop thereby making the process transparent.

With a public status page, like StatusIQ, you can post real-time updates to keep your customers updated on your active incidents or scheduled maintenance, publish postmortem reports, and more. Integrate your mobile applications with StatusIQ and help users track service status updates. 

The StatusIQ iOS SDK (StatusIQFramework) is a free module for StatusIQ. The perk is that you can integrate the StatusIQ iOS SDK with your business's mobile iOS app and showcase the service's availability. We've created a Status iOS Pod which contains the StatusIQ iOS framework. Businesses using the StatusIQ product can now integrate the Status iOS Pod in their business apps to showcase their real-time service status to clients. The integration also provides various customization options, like changing the font, color customization, and navigation.

###How to customize the StatusIQ framework 

You can customize the StatusIQ Framework UI/UX to suit your application theme.To customize, open the StatusIQ framework in XCode editor, and find the class "StatusIQCustomization". "StatusIQCustomization" provides methods to change the theme of the StatusIQ Framework.

Use this method to set the desired background color which is already used in your app. Method argument to pass the desired color is hexvalue. 

###StatusIQCustomization.setBackgroundColor(bgColor : <hexvalue>)
	
Use this method to change the Navigation Bar background color. 
Method argument to pass the desired UIColor value. 
###StatusIQCustomization.setNavigationBarBackgroundColor((barColor : <UIColor>)
	
	
Use this method to change the desired font style which is already used in your app. Method argument to pass the font name is String type. 
###StatusIQCustomization.setFontName(fontName : <String>)
	example: if you customize the StatusIQ framework by below color settings,
	Font name=Trebuchet MS
	Background color code=#f2f1ed
	Navigation bar color code = #faf0c8

<img width="325" alt="Screenshot 2021-05-03 at 5 38 14 PM" src="https://user-images.githubusercontent.com/6861082/116874232-9a304c00-ac36-11eb-80a7-fe509bb785f0.png">      		<img width="315" alt="Screenshot 2021-05-03 at 5 38 34 PM" src="https://user-images.githubusercontent.com/6861082/116874296-ba600b00-ac36-11eb-8e5f-a0ed6897c85a.png">




Follow the steps to integrate the Status iOS POD into the business app:

1. Open your business app in the XCode. 
2. Add repository source URL and POD name with your respective target on the POD file. 
	source https://git.csez.zohocorpin.com/igarage_libraries/igaragespecs.git 
        Add pod "StatusIQ"
				
	<img width="366" alt="11d3fa93-f1c6-4fcf-bad8-4b8be62d0063" src="https://user-images.githubusercontent.com/6861082/116873005-93a0d500-ac34-11eb-9360-5c162366e325.png">
3. After adding the  Pod, navigate to StatusIQInfo.plist file and under configuration "Status page url", provide your StatusIQ public page URL which you would like to showcase in the business app. If you wish to list the components you have on your StatusIQ page as your components in the business app then, in the .plist file, set the "Show Component status alone" as True. Then, provide the Component of your preference in the field "Component Name".
	
	<img width="550" alt="8923e1f5-e860-4be4-b73c-024608e01871" src="https://user-images.githubusercontent.com/6861082/116873587-9223dc80-ac35-11eb-8b03-9c77be23b207.png">


4. Based on the requirement in your business app, you can add Tap button wherever required to showcase the status.
5. After adding the Tap button,  you can import the StatusIQ framework and implement the below code in the Tap button code definition.

<img width="489" alt="45ceb268-807d-491a-a6aa-f7a7cd6bd232" src="https://user-images.githubusercontent.com/6861082/116873676-b384c880-ac35-11eb-9675-7af4414cd82c.png">







