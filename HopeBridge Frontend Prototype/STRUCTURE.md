# Flutter Project Structure

## Screens
| Screen | Route | Description |
|--------|-------|-------------|
| SplashScreen | / | App loading screen |
| UserTypeScreen | /user-type | Choose Donor or Recipient |
| LoginScreen | /login/:userType | Login page |
| SignupScreen | /signup/:userType | Registration page |
| FundraisingLandingPage | /fundraising-landing | Donor home page |
| FundraisingPage | /fundraising | Create fundraiser |
| RecipientHomePage | /recipient-home | Recipient dashboard |
| JobFinderPage | /job-finder | Search for jobs |
| JobListingPage | /job-listing | View available jobs |
| EShopPage | /eshop | Browse products |
| CartPage | /cart | Shopping cart |
| CheckoutPage | /checkout | Purchase confirmation |
| OurJourneyPage | /our-journey | About HopeBridge |
| TopTipsPage | /top-tips | Fundraising tips |

## Key Components
- HopeBridgeLogo - Reusable logo widget
- AppButton - Reusable button widget
- AppTextField - Reusable text field widget
- ApiService - Backend API integration
- TokenStorage - JWT token management
