# StatusIQ-iOS-SDK
Enterprises using StatusIQ, can integrate the iOS SDK in their Business app to showcase their public page availabilites
With mobiles and efficient business applications users can carry out all their transactions anywhere at anytime.Business services across the globe are now offering mobile applications to their users. With the growing popularity of mobile applications, it is crucial to provide real-time updates on service availability through these platforms. This can definitely help users to act proactively and tackle incidents easily.

The StatusIQ iOS SDK (StatusIQFramework) is a free supplement of StatusIQ product. The perk is that now you can integrate the StatusIQ iOS SDK to your business's mobile iOS app and showcase the service's availability. We've created a Status iOS POD which contains StatusIQ iOS Framework. Enterprises who have been using the StatusIQ product can now  integrate the Status iOS POD in their business app to showcase their real-time  service status to clients.

 

Follow the steps to integrate the Status iOS POD into the business app:

1. Open your business app in the XCode. 
2. Add repository source URL and POD name with your respective target on the POD file. 
	source 'https://github.com/site24x7/StatusIQ-iOS-Pod.git' 
           Add pod 'StatusIQ'

3. After adding the  POD, navigate to StatusIQInfo.plist file and under configuration "Status page url", provide  your StatusIQ public page URL which you would like to showcase in the business app.  If you wish to list the Components you've on your StatusIQ page as your components in the business app, then in the .plist file set the 'Show Component status alone' as True. Then provide the Component of your preference in the field 'Component Name'.



4. In your service's business app, you can add a new option by navigating to Settings  > add option 'Service Status'. 
5. After adding the option, you can import the StatusIQ framework and implement the below code in respective places  where the option is used.
6. Import the StatusIQ module :

  


### Customization of StatusIQ framework 


You can customize  StatusIQ Framework UI/UX to suit your application theme.To customize,  open the StatusIQ framework in XCode editor and you can find class 'StatusIQCustomization'. 'StatusIQCustomization' has methods to change the theme of the StatusIQ Framework.

Use this method to set the desired background color which is already used in your app. Method argument to pass the desired color is hexvalue. 
#### StatusIQCustomization.setBackgroundColor(bgColor : <hexvalue>)

Use this method to set the desired Navigation Bar background color which is already used in your app. Method argument to pass the desired UIColor value. 
#### StatusIQCustomization.setNavigationBarBackgroundColor((barColor : <UIColor>)

Use this method to set the desired font style which is already used in your app, method argument to pass the font name is String type . # 
#### StatusIQCustomization.setFontName(fontName : <String>)








