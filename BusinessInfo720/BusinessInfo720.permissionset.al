permissionset 6231700 BusinessInfo720
{
    Assignable = true;
    Permissions = tabledata BuisnessInfo720=RIMD,
        tabledata BusinessTypeTable720=RIMD,
        tabledata IndustryTable720=RIMD,
        tabledata RegnskabsTable720=RIMD,
        table BuisnessInfo720=X,
        table BusinessTypeTable720=X,
        table IndustryTable720=X,
        table RegnskabsTable720=X,
        codeunit KundeApiMgt720=X,
        codeunit VatApiMgt720=X,
        page BusinessInfo720=X,
        page BusinessInfoSubPage720=X,
        page RegnSkabFactBox720=X,
        page ReportsPage720=X,
        page VendorBusinessinfo720=X,
        page VendorBusinessInfoSubpage720=X,
        tabledata SettingsTable720=RIMD,
        table SettingsTable720=X,
        page BusinessInfoSettingsPage720=X,
        page ReportsFactBox720=X,
        tabledata WarningTable720=RIMD,
        table WarningTable720=X,
        page Warning720=X,
        page WarningCuePage720=X,
        page BusinessChart720=X;
}