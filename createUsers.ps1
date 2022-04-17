
# Import Active Directory Module
Import-Module ActiveDirectory

$csv = Import-Csv -Path C:\Users\snaval.ACME\Documents\addUsers.csv
# Read in Secure Temporary Password. Must meet complexity

$AccountPassword = Read-Host -AsSecureString -Prompt "Enter Temporary Password for New Users"

# Loop through Users
foreach ($user in $csv) {
    
    #Store USer Attributes for Splatting
    $userInfo = @{
        Name                  = $user.Name
        DisplayName           = $user.Name
        GivenName             = $user.GivenName
        Surname               = $user.Surname
        SamAccountName        = $user.SamAccountName
        Title                 = $user.Title
        Department            = $user.Department
        Company               = $user.Company
        EmailAddress          = $user.EmailAddress
        AccountPassword       = $AccountPassword
        ChangePasswordAtLogon = $true
        Path                  = $user.Path
        Enable                = $true
    }

    # Create New Users
    New-ADUser @userInfo
    
}
