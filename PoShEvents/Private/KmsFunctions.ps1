function Get-KmsLicenseState {
    param([string]$LicenseState)
    switch ($LicenseState) {
        0 { 'Unlicensed' }
        1 { 'Activated' }
        2 { 'Grace Period' }
        3 { 'Out-of-Tolerance Grace Period' }
        4 { 'Non-Genuine Grace Period' }
        5 { 'Notifications Mode' }
        6 { 'Extended Grace Period' }
    }
}

function Get-KmsErrorCode {
    param([string]$ErrorCode)
    switch ($ErrorCode) {
        { $_ -eq '0x0' -or $_ -eq '0x00000000' } { $null }
        '0xC004F035' { 'The Software Licensing Service reported that the computer could not be activated with a Volume license product key. Volume-licensed systems require upgrading from a qualifying operating system. Please contact your system administrator or use a different type of key.' }
        '0xC004F038' { 'The Software Licensing Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator.' }
        '0xC004F039' { 'The Software Licensing Service reported that the product could not be activated. The Key Management Service (KMS) is not enabled.' }
        '0x4004F040' { 'The Software Licensing Service reported that the product was activated but the owner should verify the Product Use Rights.' }
        '0x4004F041' { 'SL_I_VL_OOB_NO_BINDING_SERVER_REGISTRATION' }
        { $_ -eq '0x4004F042' -or $_ -eq '0xC004F042' } { 'The Software Licensing Service determined that the specified Key Management Service (KMS) cannot be used' }
        '0x4004F056' { 'The Software Licensing Service reported that the product could not be activated using the Key Management Service (KMS).' }
        '0xC004F015' { 'The Software Licensing Service reported that the license is not installed.' }
        '0xC004F041' { 'The Software Licensing Service determined that the Key Management Service (KMS) is not activated. KMS needs to be activated. Please contact system administrator.' }
        '0xC0020017' { 'The RPC Service is unavailable.' }
        default { $ErrorCode }
    }
}

function Get-KmsProductSku {
    param([string]$ProductSku)
    
    # see https://github.com/asaboss/py-kms-server/ for updates
    # check https://github.com/CNMan/balala/blob/master/pkconfig.csv for more updates

    switch ($ProductSku) {        
        '5DBE2163-3FA9-464C-B8B7-CAADDE61E4FF' { 'RTM_HomeStudent_OEM_Perp' }
        '09E2D37E-474B-4121-8626-58AD9BE5776F' { 'RTM_HomeStudent_Retail' }
        '8C54246A-31FE-4274-90C7-687987735848' { 'RTM_Outlook_OEM_Perp' }
        'FBF4AC36-31C8-4340-8666-79873129CF40' { 'RTM_Outlook_Retail' }
        '8FB0D83E-2BCC-43CD-871A-6AD7A06349F4' { 'RTM_Outlook_SubPrepid' }
        '2C8ACFCA-F0D9-4CCF-BA28-2F2C47DA8BA5' { 'RTM_Outlook_Trial' }
        '745FB377-0A59-4CA9-B9A9-C359557A2C4E' { 'RTM_AccessRuntime_ByPass' }
        '0B1ACA01-5C25-468F-809D-DA81CB49AC3A' { 'RTM_HomeBusinessDemo_BypassTrial' }
        'F63B84D0-ED9D-4B05-99E4-19D33FD7AFBD' { 'RTM_HomeBusiness_OEM_Perp' }
        '0EAAF923-70A2-48BD-A6F1-54CC1AA95C13' { 'RTM_HomeBusiness_OEM_Perp2' }
        '7B7D1F17-FDCB-4820-9789-9BEC6E377821' { 'RTM_HomeBusiness_Retail' }
        '4790B2A5-BBF2-4C26-976F-D7736E516CCE' { 'RTM_HomeBusiness_Trial' }
        '19316117-30A8-4773-8FD9-7F7231F4E060' { 'RTM_HomeBusinessSub_SubPrepid' }
        '8C893555-CB79-4BAA-94EA-780E01C3AB15' { 'RTM_Mondo_BypassTrial2' }
        'F6183964-39E3-46A9-A641-734041BAFF89' { 'RTM_Mondo_OEM_Perp' }
        '14F5946A-DEBC-4716-BABC-7E2C240FEC08' { 'RTM_Mondo_Retail' }
        '4671E3DF-D7B8-4502-971F-C1F86139A29A' { 'RTM_Mondo_Retail2' }
        '09AE19CA-75F8-407F-BF70-8D9F24C8D222' { 'RTM_Mondo_Retail3' }
        '3D9F0DCA-BCF1-4A47-8F90-EB53C6111AFD' { 'RTM_Mondo_SubPrepid' }
        '8A730535-A343-44EB-91A2-B1650DE0A872' { 'RTM_Mondo_Trial' }
        'EFEEFEDE-44B4-44FF-84D5-01B67A380024' { 'RTM_Mondo_Trial2' }
        'AB324F86-606E-42EC-93E3-FC755989FE19' { 'RTM_Mondo_Trial3' }
        '60CD7BD4-F23C-4E58-9D81-968591E793EA' { 'RTM_Mondo_ByPass' }
        'A42E403B-B141-4FA2-9781-647604D09BFB' { 'RTM_Mondo_BypassTrial' }
        'EF3D4E49-A53D-4D81-A2B1-2CA6C2556B2C' { 'Office Mondo 2010' }
        '533B656A-4425-480B-8E30-1A2358898350' { 'RTM_Mondo_MAK' }
        '2C971DC3-E122-4DBD-8ADF-B5777799799A' { 'RTM_Mondo_Subscription' }
        '2BCDDDBE-4EBE-4728-9594-625E26137761' { 'RTM_ProfessionalDemo_BypassTrial' }
        '1783C7A6-840C-4B33-AF05-2B1F5CD73527' { 'RTM_Professional_OEM_Perp' }
        '8B559C37-0117-413E-921B-B853AEB6E210' { 'RTM_Professional_Retail' }
        'DF01848D-8F9D-4589-9198-4AC51F2547F3' { 'RTM_Professional_Trial' }
        '71391382-EFB5-48B3-86BD-0450650FED7D' { 'RTM_GrooveServer_ByPass' }
        'B13B737A-E990-4819-BC00-1A12D88963C3' { 'RTM_GrooveServer_BypassTrial' }
        'B5300EA3-8300-42D6-A3CD-4BFFA76397BA' { 'RTM_GrooveServerEMS_ByPass' }
        '7C7F5B37-6BBA-49D2-B0DE-27CC76BCE67D' { 'RTM_GrooveServerEMS_BypassTrial' }
        '8FC4269F-A845-4D1F-9DF0-9F499C92D9CB' { 'RTM_HomeStudentDemo_BypassTrial' }
        'F10D4C70-F7CC-452A-B4B8-F12E3D6F4EEC' { 'RTM_HomeStudent_BypassTrial' }
        '0E795CCE-5BAD-40B1-8803-CE71FB89031D' { 'RTM_HomeStudent_OEM_Perp2' }
        'DDB12F7C-CE7E-4EE5-A01C-E6AF9EDBC020' { 'RTM_HomeStudent_OEM_Perp3' }
        '1CAEF4EC-ADEC-4236-A835-882F5AFD4BF0' { 'RTM_HomeStudent_Retail2' }
        '7B0FF49B-22DA-4C74-876F-B039616D9A4E' { 'RTM_HomeStudent_Retail3' }
        'AFCA9E83-152D-48A8-A492-6D552E40EE8A' { 'RTM_HomeStudent_SubPrepid' }
        '3850C794-B06F-4633-B02F-8AC4DF0A059F' { 'RTM_HomeStudent_Trial' }
        'ED21638F-97FF-4A65-AD9B-6889B93065E2' { 'RTM_ProjectServer_ByPass' }
        '84902853-59F6-4B20-BC7C-DE4F419FEFAD' { 'RTM_ProjectServer_BypassTrial' }
        'D3422CFB-8D8B-4EAD-99F9-EAB0CCD990D7' { 'RTM_Standard_Retail' }
        'BC8275B7-D67A-4390-8C5E-CC57CFC74328' { 'RTM_Standard_SubPrepid' }
        '2BEB303E-66C6-4422-B2EC-5AEA48B75EE5' { 'RTM_HomeBusiness_BypassTrial' }
        '00B6BBFC-4091-4182-BB81-93A9A6DEB46A' { 'RTM_HomeBusiness_OEM_Perp3' }
        '00495466-527F-442F-A681-F36FAD813F86' { 'RTM_HomeBusiness_Retail2' }
        '4EFBD4C4-5422-434C-8C25-75DA21B9381C' { 'RTM_HomeBusiness_Retail3' }
        'B21DA2D5-50F1-4C5C-BF59-07BAA35E25BA' { 'RTM_HomeBusiness_SubPrepid' }
        '1DFBB6C1-0C4D-44E9-A0EA-77F59146E011' { 'RTM_HomeBusiness_Trial2' }
        'AB586F5C-5256-4632-962F-FEFD8B49E6F4' { 'Office OneNote 2010' }
        '6860B31F-6A67-48B8-84B9-E312B3485C4B' { 'RTM_OneNote_MAK' }
        '4365667B-8304-463E-B542-2DF8D0A73EA9' { 'RTM_Professional_BypassTrial' }
        '6912CCDF-557A-497C-9903-3DE6CE9FA631' { 'RTM_Professional_DeltaTrial' }
        '7D4627B9-9467-4AA7-AE7F-892807D78D8F' { 'RTM_Professional_OEM_Perp2' }
        '7E05FC0C-7CE4-4849-BB0B-231BDF5DCA70' { 'RTM_Professional_OEM_Perp3' }
        '50AC2361-FE88-4E5E-B0B2-13ACC96CA9AE' { 'RTM_Professional_Retail2' }
        'A7971F62-61D0-4C67-ABCC-085C10CF470F' { 'RTM_Professional_Retail3' }
        '71FB05B7-19E2-4567-AF77-8F31681D39D2' { 'RTM_Professional_SubPrepid' }
        '42122F59-2850-485E-B0C0-1AACA1C88923' { 'RTM_Professional_Trial2' }
        '9F82274C-C0EF-4212-B8D9-97A6BFBC2DC7' { 'RTM_HSOneNote_OEM_Perp' }
        '25FE4611-B44D-49CC-AE87-2143D299194E' { 'RTM_HSOneNote_Retail' }
        'D82665D5-2D8F-46BA-ABEC-FDF06206B956' { 'RTM_HSOneNote_SubPrepid' }
        'B49D9ABE-7F30-40AA-9A4C-BDE08A14832D' { 'RTM_HSOneNote_Trial' }
        'D79A3F4F-E768-4114-8D3A-7F9F45687F67' { 'RTM_HSWord_OEM_Perp' }
        'A963D7AE-7A88-41A7-94DA-8BB5635A8AF9' { 'RTM_HSWord_Retail' }
        'C735DCC2-F5E9-4077-A72F-4B6D254DDC43' { 'RTM_HSWord_SubPrepid' }
        '533D80CB-BF68-48DB-AB3E-165B5377599E' { 'RTM_HSWord_Trial' }
        '115A5CF2-D4CF-4627-91DC-839DF666D082' { 'RTM_OneNote_OEM_Perp' }
        '3F7AA693-9A7E-44FC-9309-BB3D8E604925' { 'RTM_OneNote_Retail' }
        '698FA94F-EB99-43BE-AB8C-5A085C36936C' { 'RTM_OneNote_SubPrepid' }
        '8CC3794C-4B71-44EA-BAAE-D95CC1D17042' { 'RTM_OneNote_Trial' }
        'AF2AFE5B-55DD-4252-AF42-E6F79CC07EBC' { 'RTM_SmallBusBasicsMSDN_Retail' }
        'EA509E87-07A1-4A45-9EDC-EBA5A39F36AF' { 'Office Small Business Basics 2010' }
        '8090771E-D41A-4482-929E-DE87F1F47E46' { 'RTM_SmallBusBasics_MAK' }
        'BED40A3E-6ACA-4512-8012-70AE831A2FC5' { 'RTM_Word_OEM_Perp' }
        'DB3BBC9C-CE52-41D1-A46F-1A1D68059119' { 'RTM_Word_Retail' }
        '99279F42-6DE2-4346-87B1-B0EC99C7525C' { 'RTM_Word_SubPrepid' }
        '195E23D7-E0B7-4C30-8A30-8E9941AFD07E' { 'RTM_Word_Trial' }
        '1359DCE0-0DC8-4171-8C43-BA8B9F2E5D1D' { 'RTM_VisioPro_OEM_Perp' }
        'D0A97E12-08A1-4A45-ADD5-1155B204E766' { 'RTM_VisioPro_Retail' }
        '0993043D-664F-4B2E-A7F1-FD92091FA81F' { 'RTM_VisioPro_Retail2' }
        '0EC894E8-A5A9-48DE-9463-061C4801EE8F' { 'RTM_VisioPro_SubPrepid' }
        '673EA9EA-9BC0-463F-93E5-F77655E46630' { 'RTM_VisioPro_Trial' }
        '3B02A9FF-CED3-46D6-9298-A4334829748F' { 'RTM_PersonalDemo_BypassTrial' }
        '20F986B2-048B-4810-9421-73F31CA97657' { 'RTM_PersonalPrepaid_Trial' }
        '40EC9524-41D7-41D7-95C7-E5F185F92EA3' { 'RTM_Personal_OEM_Perp' }
        'ACB51361-C0DB-4895-9497-1831C41F31A6' { 'RTM_Personal_Retail' }
        '45AB9E9F-C1DC-4BC7-8E37-89E0C1241776' { 'RTM_Personal_Retail2' }
        '148CE971-9CCE-4DE0-9FD6-4871BEBD5666' { 'RTM_Personal_SubPrepid' }
        'E98EF0C0-71C4-42CE-8305-287D8721E26C' { 'RTM_ProPlusSub_SubPrepid' }
        'BB42DD2B-070C-4F5B-947A-55F56A16D4F3' { 'RTM_VisioPrem_OEM_Perp' }
        '66CAD568-C2DC-459D-93EC-2F3CB967EE34' { 'RTM_VisioPrem_Retail' }
        '3513C04B-9085-43A9-8F9A-639993C19E80' { 'RTM_VisioPrem_SubPrepid' }
        '7616C283-5C5B-4054-B52C-902F03E4DCDF' { 'RTM_VisioPrem_Trial' }
        '0B172E55-95AE-4C78-8C58-81AA98AB7F94' { 'RTM_VisioPro_OEM_Perp2' }
        '40BECF98-1D17-43EF-989F-1D92396A2741' { 'RTM_VisioStd_OEM_Perp' }
        'BA24D057-8B5F-462E-87FE-485038C68954' { 'RTM_VisioStd_Retail' }
        '4CC91C85-44A8-4834-B15D-FFEA4616E4E4' { 'RTM_VisioStd_SubPrepid' }
        'A27DF0C4-AE71-4DDD-BBEB-6D6222FE3A17' { 'RTM_VisioStd_Trial' }
        '2D0882E7-A4E7-423B-8CCC-70D91E0158B1' { 'Office Word 2010' }
        '98D4050E-9C98-49BF-9BE1-85E12EB3AB13' { 'RTM_Word_MAK' }
        'FABC9393-6174-4192-B3EE-6340E16CF90D' { 'RTM_ProjectPro_OEM_Perp' }
        '725714D7-D58F-4D12-9FA8-35873C6F7215' { 'RTM_ProjectPro_Retail' }
        'AA188B61-D3D3-443C-9DEC-5B42393EE5CB' { 'RTM_ProjectPro_Retail2' }
        '9A13EB9C-006F-450A-9F59-4CEC1EAB88F5' { 'RTM_ProjectPro_SubPrepid' }
        '694E35B9-F965-47D7-AA19-AB2783224ADF' { 'RTM_ProjectPro_Trial' }
        'EAEED721-9715-46FC-B2F8-03EEA2EF1FE2' { 'RTM_Excel_OEM_Perp' }
        '4EAFF0D0-C6CB-4187-94F3-C7656D49A0AA' { 'RTM_Excel_Retail' }
        '0BE50797-9053-4F15-B9B1-2F2C5A310816' { 'RTM_Excel_SubPrepid' }
        '8FC26056-52E4-4519-889F-CDBEDEAC7C31' { 'RTM_Excel_Trial' }
        '09ED9640-F020-400A-ACD8-D7D867DFD9C2' { 'Office Mondo 2010' }
        '247E7706-0D68-4F56-8D78-2B8147A11CA8' { 'RTM_PowerPoint_OEM_Perp' }
        '133C8359-4E93-4241-8118-30BB18737EA0' { 'RTM_PowerPoint_Retail' }
        '1EEA4120-6699-47E9-9E5D-2305EE108BAC' { 'RTM_PowerPoint_SubPrepid' }
        '1C57AD8F-60BE-4CE0-82EC-8F55AA09751F' { 'RTM_PowerPoint_Trial' }
        '8B1F0A02-07D6-411C-9FC7-9CAA3F86D1FE' { 'RTM_ProjectStd_OEM_Perp' }
        '688F6589-2BD9-424E-A152-B13F36AA6DE1' { 'RTM_ProjectStd_Retail' }
        'F4C9C7E4-8C96-4513-ADA3-0A514B3AC5CF' { 'RTM_ProjectStd_SubPrepid' }
        'F510F8DE-4325-4461-BD33-571EDBE0A933' { 'RTM_ProjectStd_Trial' }
        '191301D3-A579-428C-B0C7-D7988500F9E3' { 'RTM_ProPlusAcad_MAK' }
        '42CBF3F6-4D5E-49C6-991A-0D99B8429A6D' { 'RTM_ProPlusMSDN_Retail' }
        '4E6F61A8-989B-463C-9948-83B894540AD4' { 'RTM_Publisher_OEM_Perp' }
        '98677603-A668-4FA4-9980-3F1F05F78F69' { 'RTM_Publisher_Retail' }
        '17B7CE1A-92A9-4B59-A7D0-E872D8A9A994' { 'RTM_Publisher_SubPrepid' }
        '1A069855-55EC-4CCF-9C45-2AC5D500F792' { 'RTM_Publisher_Trial' }
        'DD457678-5C3E-48E4-BC67-A89B7A3E3B44' { 'RTM_StandardAcad_MAK' }
        'B6D2565C-341D-4768-AD7D-ADDBE00BB5CE' { 'RTM_StandardMSDN_Retail' }
        '9DA2A678-FB6B-4E67-AB84-60DD6A9C819A' { 'Office Standard 2010' }
        '1F76E346-E0BE-49BC-9954-70EC53A4FCFE' { 'RTM_Standard_MAK' }
        '3FDFBCC8-B3E4-4482-91FA-122C6432805C' { 'RTM_MOSS_ByPass' }
        'B2C0B444-3914-4ACB-A0B8-7CF50A8F7AA0' { 'RTM_MOSS_BypassTrial' }
        '1F230F82-E3BA-4053-9B6D-E8F061A933FC' { 'RTM_MOSSFISEnt_ByPass' }
        'F48AC5F3-0E33-44D8-A6A9-A629355F3F0C' { 'RTM_MOSSFISEnt_BypassTrial' }
        '9C2C3D66-B43B-4C22-B105-67BDD5BB6E85' { 'RTM_MOSSFISStd_ByPass' }
        '8F23C830-C19B-4249-A181-B20B6DCF7DBE' { 'RTM_MOSSFISStd_BypassTrial' }
        'D5595F62-449B-4061-B0B2-0CBAD410BB51' { 'RTM_MOSSPremium_ByPass' }
        '88BED06D-8C6B-4E62-AB01-546D6005FE97' { 'RTM_MOSSPremium_BypassTrial' }
        'C1CEDA8B-C578-4D5D-A4AA-23626BE4E234' { 'RTM_OEM_ByPass' }
        'AE3ED6AE-2654-4B82-A4BA-331265BB8972' { 'RTM_ProfessionalAcad_OEM_Perp' }
        'C4109E90-6C4A-44F6-B380-EF6137122F16' { 'RTM_ProfessionalAcad_Retail' }
        '23037F94-D654-4F38-962F-FF5B15348630' { 'RTM_ProfessionalAcad_Trial' }
        '75BB133B-F5DD-423C-8321-3BD0B50322A5' { 'RTM_ProPlusAcad_Retail' }
        '88B5EC99-C9D1-47F9-B1F2-3C6C63929B7B' { 'RTM_SmallBusBasics_OEM_Perp' }
        'DBE3AEE0-5183-4FF7-8142-66050173CB01' { 'RTM_SmallBusBasics_Retail' }
        '08CEF85D-8704-417E-A749-B87C7D218CAD' { 'RTM_SmallBusBasics_SubPrepid' }
        '4519ABCF-23DB-487B-AC28-7C9EBE801716' { 'RTM_SmallBusBasics_Trial' }
        '8CE7E872-188C-4B98-9D90-F8F90B7AAD02' { 'Office Access 2010' }
        '95AB3EC8-4106-4F9D-B632-03C019D1D23F' { 'RTM_Access_MAK' }
        '209408DF-98DB-4EEB-B96B-D0B9A4B13468' { 'RTM_Groove_OEM_Perp' }
        '7004B7F0-6407-4F45-8EAC-966E5F868BDE' { 'RTM_Groove_Retail' }
        '84155B23-BAE0-4748-967B-40E12917B0BB' { 'RTM_Groove_SubPrepid' }
        'DD1E0912-6816-4DC2-A8BF-AA2971DB0E25' { 'RTM_Groove_Trial' }
        '8C7E3A91-E176-4AB3-84B9-A7E0EFB3A6DD' { 'RTM_HSExcel_OEM_Perp' }
        'C3AE020C-5A71-4CC5-A27A-2A97C2D46860' { 'RTM_HSExcel_Retail' }
        'C7DF3516-425A-4A84-9420-0112F3094D90' { 'RTM_HSExcel_SubPrepid' }
        'F4F25E2B-C13C-4256-8E4C-5D4D82E1B862' { 'RTM_HSExcel_Trial' }
        '95FF18B9-F2CF-4291-AB2E-BC17D54AA756' { 'RTM_HSPowerPoint_OEM_Perp' }
        'D652AD8D-DA5C-4358-B928-7FB1B4DE7A7C' { 'RTM_HSPowerPoint_Retail' }
        '31E631F4-EE62-4B1F-AEB6-3B30393E0045' { 'RTM_HSPowerPoint_SubPrepid' }
        '131E900A-EFA8-412E-BA20-CB0F4BE43054' { 'RTM_HSPowerPoint_Trial' }
        '866AC003-01A0-49FD-A6EC-F8F56ABDCFAB' { 'RTM_InfoPath_OEM_Perp' }
        'EF1DA464-01C8-43A6-91AF-E4E5713744F9' { 'RTM_InfoPath_Retail' }
        '0209AC7B-8A4B-450B-92F2-B583152A2613' { 'RTM_InfoPath_SubPrepid' }
        '4F0B7650-A09D-4180-976D-76D8B31EA1B4' { 'RTM_InfoPath_Trial' }
        '7B8EBE34-08FC-46C5-8BFA-161B12A43E41' { 'RTM_ProjectPro_OEM_Perp2' }
        'FD2BBCED-F8DB-45BC-B4D6-AC05A47D3691' { 'RTM_ProjectPro_Trial2' }
        '8C5EDB5D-9AA0-47A7-9416-D61C7419A60A' { 'RTM_ProPlusMSDN_Retail2' }
        '6F327760-8C5C-417C-9B61-836A98287E0C' { 'Office Professional Plus 2010' }
        'BFE7A195-4F8F-4F0B-A622-CF13C7D16864' { 'RTM_ProPlus_KMS_Host' }
        'FDF3ECB9-B56F-43B2-A9B8-1B48B6BAE1A7' { 'RTM_ProPlus_MAK' }
        '2637E47C-CD16-45A1-8FF7-B7938723FD10' { 'RTM_HomeBusinessSub_Subscription' }
        'F3329A70-BB26-4DD1-AF64-68E10C1AE635' { 'RTM_OfficeLPK_ByPass' }
        'ECB7C192-73AB-4DED-ACF4-2399B095D0CC' { 'Office OutLook 2010' }
        'A9AEABD8-63B8-4079-A28E-F531807FD6B8' { 'RTM_Outlook_MAK' }
        '288B2C51-35B5-41CA-AA5B-524DA113B4BD' { 'RTM_ProjectLPK_ByPass' }
        '47A5840C-8124-4A1F-A447-50168CD6833D' { 'RTM_ProjectProMSDN_Retail' }
        '4D06F72E-FD50-4BC2-A24B-D448D7F17EF2' { 'RTM_ProjectProSub_SubPrepid' }
        '3047CDE0-03E2-4BAE-ABC9-40AD640B418D' { 'RTM_ProjectProSub_Subscription' }
        'DF133FF7-BF14-4F95-AFE3-7B48E7E331EF' { 'Office Project Pro 2010' }
        '1CF57A59-C532-4E56-9A7D-FFA2FE94B474' { 'RTM_ProjectPro_MAK' }
        '5DC7BF61-5EC9-4996-9CCB-DF806A2D0EFE' { 'Office Project Standard 2010' }
        '11B39439-6B93-4642-9570-F2EB81BE2238' { 'RTM_ProjectStd_MAK' }
        '71AF7E84-93E6-4363-9B69-699E04E74071' { 'RTM_ProPlus_Retail' }
        '46C84AAD-65C7-482D-B82A-1EDC52E6989A' { 'RTM_ProPlus_Retail2' }
        '28FE27A7-2E11-4C05-8DD0-E1F1C08DC3AE' { 'RTM_ProPlus_SubPrepid' }
        '8C5FA740-5DCA-43F9-BE1B-D0281BCF9779' { 'RTM_ProPlus_Trial' }
        'AE28E0AB-590F-4BE3-B7F6-438DDA6C0B1C' { 'RTM_ProPlusSub_Subscription' }
        'A4F824FC-C80E-4111-9884-DCEECE7D81A1' { 'RTM_PTK_ByPass' }
        '08460AA2-A176-442C-BDCA-26928704D80B' { 'RTM_SearchServer_ByPass' }
        'BC4C1C97-9013-4033-A0DD-9DC9E6D6C887' { 'RTM_SearchServer_BypassTrial' }
        '1328E89E-7EC8-4F7E-809E-7E945796E511' { 'RTM_SearchServerExpress_ByPass' }
        'DAF85377-642C-4222-BCD8-DF5925C70AFB' { 'RTM_ServerLPK_ByPass' }
        'B78DF69E-0966-40B1-AE85-30A5134DEDD0' { 'RTM_SPD_ByPass' }
        '59EC6B79-F6F5-4ADD-A5A0-B755BFB77422' { 'RTM_StarterPrem_SubPrepid' }
        '2745E581-565A-4670-AE90-6BF7C57FFE43' { 'RTM_Starter_ByPass' }
        'EFF34BA1-2794-4908-9501-5190C8F2025E' { 'RTM_Sub4_Subscription' }
        '4A8825CE-A527-4A42-B59C-17B22CFE644F' { 'RTM_VisioLPK_ByPass' }
        '926E4E17-087B-47D1-8BD7-91A394BC6196' { 'RTM_WCServer_ByPass' }
        '2D45B535-68E6-44E0-8496-FC74F1491566' { 'RTM_WCServer_BypassTrial' }
        '99ff9b26-016a-49d3-982e-fc492f352e57' { 'Windows Vista Business - GVLK' }
        '277f97c7-ffde-47da-b7c4-6451bd00f2ec' { 'Windows Vista Business/SB' }
        '5d0b855e-cbe7-4f6d-93bd-5ab3befc5bfe' { 'Windows Vista Business N' }
        'a5829b27-5111-45b5-8f96-58f59c7c8e06' { 'Windows Vista Business/Enterprise - MAK' }
        'cf67834d-db4a-402c-ab1f-2c134f02b700' { 'Windows Vista Enterprise - GVLK' }
        'c0be86d5-c12e-4658-880c-3079a2b70a42' { 'Longhorn Home Basic' }
        'a0103e3a-99bd-41b1-84c5-77c98856d538' { 'Longhorn Home Basic - OEM' }
        '68d73c70-5fdd-42dd-bfd0-476d274fcca6' { 'Windows Vista Home Basic N' }
        '6a426eed-440e-4dcc-8661-2b0731ef764f' { 'Longhorn Home Premium' }
        '5a9b0253-41d9-4818-94ca-24153a333bb4' { 'Longhorn Home Premium - OEM' }
        'be6f6d4a-4378-4c58-9756-349afa6818ac' { 'LH Pro Std/SBS/Ent - VL Binding Service' }
        'af743c9a-e298-419e-ac41-a1ff22ff558b' { 'Windows Vista Starter Digital Boost - OEM' }
        '5ea7b0e1-8ab1-4a6a-9b64-f967db49fb2a' { 'Windows Vista Ultimate - OCUR' }
        'b9a68c83-16e0-4547-a3d5-ea4ad899b63e' { 'Longhorn Enterprise Server - OEM' }
        '4bc32e2f-76a8-41e2-93f3-bda7ad012b3f' { 'Longhorn Pro Standard/SBS - OEM' }
        'a2f9cc7b-aa41-4386-b745-8e9b1c831a44' { 'Longhorn Datacenter Server' }
        'c9da5d13-70a5-4023-ab1e-ee9415c2c476' { 'Longhorn Enterprise Server (ADS)' }
        '080abd49-69a4-490d-98f9-00c9dbb748a6' { 'Longhorn Enterprise Server - IA64' }
        '71915630-6184-4aa2-8a02-420b14b96f25' { 'Longhorn Standard Server ' }
        '3a351259-cd74-4e6e-9e85-820687bbd337' { 'Longhorn Starter Edition' }
        'ef8251b0-5f16-4fdf-b30a-9be2286d1509' { 'Longhorn Ultimate' }
        '922e9409-ee45-4660-ba4e-a1792c7a197a' { 'Longhorn Ultimate - OEM' }
        '4B17D082-D27D-467D-9E70-40B805714C0A' { 'RTM_Access_OEM_Perp' }
        '4D463C2C-0505-4626-8CDB-A4DA82E2D8ED' { 'RTM_Access_Retail' }
        'B3DADE99-DE64-4CEC-BCC7-A584D510782A' { 'RTM_Access_SubPrepid' }
        'ED826596-52C4-4A81-85BD-0F343CBC6D67' { 'RTM_Access_Trial' }
        'CEE5D470-6E3B-4FCC-8C2B-D17428568A9F' { 'Office Excel 2010' }
        '71DC86FF-F056-40D0-8FFB-9592705C9B76' { 'RTM_Excel_MAK' }
        '8947D0B8-C33B-43E1-8C56-9B674C052832' { 'Office Groove 2010' }
        'FDAD0DFA-417D-4B4F-93E4-64EA8867B7FD' { 'RTM_Groove_MAK' }
        'CA6B6639-4AD6-40AE-A575-14DEE07F6430' { 'Office InfoPath 2010' }
        '85E22450-B741-430C-A172-A37962C938AF' { 'RTM_InfoPath_MAK' }
        '45593B1D-DFB1-4E91-BBFB-2D5D0CE2227A' { 'Office PowerPoint 2010' }
        '38252940-718C-4AA6-81A4-135398E53851' { 'RTM_PowerPoint_MAK' }
        'B6E9FAE1-1A0E-4C61-99D0-4AF068915378' { 'RTM_ProjectStd_MAK2' }
        'B50C4F75-599B-43E8-8DCD-1081A7967241' { 'Office Publisher 2010' }
        '3D014759-B128-4466-9018-E80F6320D9D0' { 'RTM_Publisher_MAK' }
        '15A9D881-3184-45E0-B407-466A68A691B1' { 'RTM_VisioProMSDN_Retail' }
        '92236105-BB67-494F-94C7-7F7A607929BD' { 'Office Visio Premium 2010' }
        '36756CB8-8E69-4D11-9522-68899507CD6A' { 'RTM_VisioPrem_MAK' }
        'E558389C-83C3-4B29-ADFE-5E4D7F46C358' { 'Office Visio Pro 2010' }
        '5980CF2B-E460-48AF-921E-0C2A79025D23' { 'RTM_VisioPro_MAK' }
        '9ED833FF-4F92-4F36-B370-8683A4F13275' { 'Office Visio Standard 2010' }
        'CAB3A4C4-F31A-4C12-AFA9-A0EECC86BD95' { 'RTM_VisioStd_MAK' }
        '6d2677aa-d088-4a22-8683-6eb555c77b98' { 'Win 7 Business - TBA' }
        '7d23d097-aad6-4a90-8a32-a1f6fd434caa' { 'Win 7 Business - TBB' }
        '6777acf0-bc42-49a9-8c35-92522168eb4c' { 'Win 7 Business - TBC' }
        'ce4e1ef5-0475-4c0f-8a01-ae6dcaf5e8a7' { 'Win 7 Business - TBD' }
        '957ec1e8-97cd-42a8-a091-01a30cf779da' { 'Win 7 Business GVLK' }
        'b44b9fa6-906b-4dbd-81be-11e23f5d797e' { 'Win 7 Business OEM:COA' }
        '9ba9fe3a-d3cf-493f-9ad7-9f63d9960c0b' { 'Win 7 Business OEM:NONSLP' }
        '979bfd90-ff9c-4847-8768-cf9cfcfeec38' { 'Win 7 Business OEM:SLP' }
        '1e0d9956-0016-4b6f-9251-0f54fa99e8e3' { 'Win 7 Business retail' }
        '0761585a-2ba4-4f2e-bae8-88c204f70d93' { 'Windows Vista Business' }
        'cd04deab-6f73-4ac4-826c-09d2ae22e818' { 'Windows Vista Business - D-OEM (CHS & RU)' }
        '90284483-de09-44a2-a406-98957f8dd09d' { 'Windows Vista Business - GVLK' }
        'a50faa13-7694-4abd-8b74-042ecc8acc2c' { 'Windows Vista Business - OEM nonSLP/SBC COA' }
        '4fe8fb4b-b264-4378-a15d-2f275fc213a0' { 'Windows Vista Business - OEM SLP COA' }
        'f9aff482-8e81-47a6-8cf6-74be7649be6f' { 'Win 7 client all editions CSVLK' }
        '6e3f3f5d-2d93-481a-969e-7ce95bb45e1e' { 'Win 7 client all editions MAK' }
        'b8cf7a60-5668-41b0-addd-6de32e69b0c6' { 'Windows Vista ALL Volume SKUs - CSVLK' }
        '3c92f348-df6e-4cf0-961c-9851328ba3e3' { 'Windows Vista Business+N/Enterprise - MAK' }
        '0ff4e536-a746-4018-b107-e81dd0b6d33a' { 'Win 7 Business N GVLK' }
        '235f6b53-3b19-429b-9fc4-f6fb4ccd06a6' { 'Win 7 Business N OEM:COA' }
        '3446d8ac-4e90-4f5e-9936-4ce92dca39f5' { 'Win 7 Business N OEM:NONSLP' }
        'd7d68bcf-bb33-492c-88fe-5f58185dadc0' { 'Win 7 Business N OEM:SLP' }
        '23f0a19f-0a14-454d-82d1-6ecd116ab1f7' { 'Win 7 Business N retail' }
        '95158e38-c18c-4c6e-a450-7e5c19822ccb' { 'Windows Vista Business N' }
        'af46f56f-f06b-49f0-a420-caa8a8d2bf8c' { 'Windows Vista Business N - GVLK' }
        '6e1ebb55-1b5f-453e-9d60-206fe2bdcdde' { 'Win 7 Enterprise - Eval' }
        'dc249460-3f0b-4d57-9349-df4d59946ca0' { 'Win 7 Enterprise - Promo' }
        'f4dba1f6-8a90-4a3a-9783-ec97a17cd5ba' { 'Win 7 Enterprise - Sub' }
        'bcfbd654-2254-48d1-b050-f0d76596cd8d' { 'Win 7 Enterprise - TBB' }
        'ea77973e-4930-4fa1-a899-02dfaeada1db' { 'Win 7 Enterprise GVLK' }
        'a620dd57-1873-4701-91bf-b5a12f81fb13' { 'Win 7 Enterprise OEM:SLP' }
        '4840ccc0-a330-4a0b-b70e-4cee4a292134' { 'Win 7 Enterprise retail' }
        '9a7e05c0-a424-4fe5-b786-09fdf615cf07' { 'Windows Vista Enterprise' }
        '14478aca-ea15-4958-ac34-359281101c99' { 'Windows Vista Enterprise - GVLK' }
        'b6e740a1-8030-4570-a441-5b20707fac70' { 'Windows Vista Enterprise - SLP Bypass' }
        '2aa4cd38-eb25-4794-91dc-398f765bc4fd' { 'Windows Vista Enterprise Eval' }
        'e4ecef68-4372-4740-98e8-6c157cd301c2' { 'Win 7 Enterprise N GVLK' }
        '526ec0b1-0e38-46c4-866e-2a3e72093839' { 'Win 7 Enterprise N OEM:SLP' }
        'cef7d759-9fc2-4d09-bf27-8ff4861b4134' { 'Win 7 Enterprise N retail' }
        '019e76ba-0233-4cd9-b26b-a2593aa76a20' { 'Win 7 Enterprise N Retail:TB:Promo WGP Test' }
        'cd0cfd17-756e-42aa-b3d7-c10e2f8295ed' { 'Win 7 Enterprise N Retail:TB:Sub WGP Test' }
        '51a662bd-0452-4d7b-9962-7e59cda72f04' { 'Win 7 Enterprise N Retail:TB:Trial WGP Test' }
        '38e8eb90-859b-409a-a6ca-db43a18fae86' { 'Win 7 Enterprise N TB:Eval WGP Test' }
        'd0997a77-2ecb-42a5-9b18-816ac1d91287' { 'Windows Vista Enterprise N' }
        '0707c7fc-143d-46a4-a830-3705e908202c' { 'Windows Vista Enterprise N - GVLK' }
        'b8929dfa-5b29-4feb-a30b-6c2d0ac0b458' { 'Windows Vista Enterprise N - OEM SLP' }
        'ee44a7bd-a8d8-45bd-9362-9fc683c0a1c6' { 'PK3 Windows Embedded Standard 8 00140 DLA/Bypass Retail:TB:Eval Toolkit' }
        '024746cf-7cc4-4a6a-842d-f2eb19bc7880' { 'Visual Basic 2010 Express (Registered)' }
        '534f372b-3700-434d-acfb-ac0778830527' { 'Visual C# 2010 Express (Registered)' }
        '11bcd841-36cb-4fe8-9acf-18748ca3fdc1' { 'Visual C++ 2010 Express (Registered)' }
        '964f3d2a-ecba-4ac6-a826-b9f7b6c79beb' { 'Visual Studio 2010 Integrated Shell' }
        '0d2fcc96-c7f3-492e-97b9-0ea89b304704' { 'Visual Studio 2010 Isolated Shell' }
        '5e95d645-53ce-4293-b520-deefca9204d3' { 'Visual Studio 2010 Kitty Hawk' }
        '2ab4e7eb-bc41-4835-858d-c8d752455ffc' { 'Visual Studio 2010 Lab Agent' }
        '135591df-c7db-44ec-a832-0d9e594a58a6' { 'Visual Studio 2010 Lab Management' }
        '7194a3f5-0f39-4418-8dcb-5cca9edd57b1' { 'Visual Studio 2010 MSDN Library' }
        'c512fd4c-0a53-4c07-ad23-a8f1ca8ca6e9' { 'Visual Studio 2010 Professional' }
        '66775d17-0b3a-495a-b1a6-7f5d0604c02c' { 'Visual Studio 2010 Professional (Academic)' }
        '91f7dea2-6bcd-46c7-8df4-ff5c82e39337' { 'Visual Studio 2010 Team Essentials' }
        '429d45d3-9eec-4f64-b1d8-952ae7ccc20f' { 'Visual Studio 2010 Team Foundation Client (Team Explorer)' }
        'db7a9f88-0f96-436a-8b9a-9717c8e31ac8' { 'Visual Studio 2010 Team Foundation Server' }
        '93a5b526-378a-4897-af93-955e1b3c6f4f' { 'Visual Studio 2010 Team Foundation Server Essentials' }
        '7c06ac1b-2a18-42df-9315-aa82ae00bd51' { 'Visual Studio 2010 Team Suite' }
        'b52f26ba-cb7d-4537-a71a-b3f4268a0f97' { 'Visual Studio 2010 Test Essentials' }
        '678e386f-f1ce-4331-9cc4-9fb905b81154' { 'Visual Studio 2010 Test Load Agent' }
        '0bc3b5f3-c3e3-40ab-acc7-dc0ae688bc60' { 'Visual Studio 2010 Test Load Agent Controller' }
        '44835d15-f3eb-4628-8d85-81d7113300bb' { 'Visual Studio 2010 Test Load Agent Controller (Retail 2.5K pack)' }
        '063edc71-2d0e-4bfa-ac17-2a1f45919ba8' { 'Visual Studio 2010 Test Load Agent Controller (Retail 500 pack)' }
        'cd42483a-0f5e-409f-92d7-ff8bfce85efd' { 'Visual Studio 2010 Test Load Agent Controller (Retail 5k pack)' }
        '869e2742-4d3e-4f0b-a2a1-8c2303edc6e2' { 'Visual Web Developer 2010 Express (Registered)' }
        '21afb54e-362c-411f-a3a4-b88cca1d26c0' { 'Win 7 Home Basic OEM:COA' }
        '49ed9851-7bdf-4da5-8791-4829c35607b6' { 'Win 7 Home Basic OEM:NONSLP' }
        '8bee0b4d-198b-4152-aa8e-ee7ae1f53979' { 'Win 7 Home Basic OEM:SLP' }
        '2ea0af61-ce6f-46c1-badf-452fe80b1385' { 'Win 7 Home Basic retail' }
        'b3156fba-90de-4c16-aa5b-3b9674bc1df4' { 'Win 7 Home Basic Retail:TB:Promo WGP Test' }
        '77d4c66d-9025-4c1c-8767-12a7be2a339f' { 'Win 7 Home Basic Retail:TB:Sub WGP Test' }
        'bbc9acbb-b61d-4805-a551-c669644d0ae4' { 'Win 7 Home Basic Retail:TB:Trial WGP Test' }
        '42b91b2e-b029-4786-a437-2887065da1aa' { 'Win 7 Home Basic TB:Eval WGP Test' }
        '1fb350e3-9ee4-4ee0-aad0-2f84bd844394' { 'Windows Vista Home Basic' }
        '14108a69-7278-4841-b915-1227ddb40774' { 'Windows Vista Home Basic - OEM nonSLP/SBC COA' }
        '40ec3399-60d5-427d-aa44-4c3f1bd3733e' { 'Windows Vista Home Basic - OEM SLP COA' }
        '881ea035-fccc-49c2-b014-8de55bb3cb5e' { 'Windwos Vista Home Basic - D-OEM (CHS & RU)' }
        'aa45b843-4d88-41f5-8dca-11a601936395' { 'Win 7 Home Basic N OEM:COA' }
        '1710f7e5-0623-4199-806f-29413aea5bbe' { 'Win 7 Home Basic N OEM:NONSLP' }
        'c34704f3-50a8-4c73-8180-b37e35cf5a1f' { 'Win 7 Home Basic N OEM:SLP' }
        '7f915424-4c5f-4f98-9c1a-28f5f36a91bc' { 'Win 7 Home Basic N retail' }
        'f95a1596-2bcc-41a8-b475-688ffdc52ce2' { 'Windows Vista Home Basic N' }
        'EFF11B33-79B0-4D87-B05F-AE5E4EC5F209' { 'RTM_HomeBusinessSub_Subscription2' }
        '56d76e98-dba5-40b1-b2fb-2d695828004b' { 'PUP-DL Vista Home Premium upg from Vista Home Basic' }
        '3d139eac-07ce-4ae2-a904-3fe333399058' { 'Win 7 Home Premium OEM:COA' }
        'c1c4986f-0343-4fc3-8dca-cc9eb19a419a' { 'Win 7 Home Premium OEM:NONSLP' }
        '0c3b0091-731d-4710-b2bf-093633ce4102' { 'Win 7 Home Premium OEM:SLP' }
        '44fa382c-dee1-44c1-bb2c-ca630787d509' { 'Win 7 Home Premium retail' }
        '4b316bfa-9ecf-4b4e-aa82-f33c886d0cfc' { 'Win 7 Home Premium TB:Eval WGP Test' }
        '4f86c7ac-6d39-4095-8fb3-56f30cf6747a' { 'Win 7 Home Premium TB:Promo WGP Test' }
        'b297e2f8-c8d9-4f0d-a840-31179dd9f21f' { 'Win 7 Home Premium TB:Sub WGP Test' }
        'af18ca6f-42d8-44e7-b890-939c1d2644c8' { 'Win 7 Home Premium TB:Trial WGP Test' }
        '465f39d6-319f-4135-a96f-59e74378557b' { 'Windows Home Premium' }
        '3ee09c34-7752-4e95-a6f3-52d343bf1064' { 'Windows Home Premium - D-OEM (CHS & RU)' }
        '47581abb-3ba8-421a-aa2d-d1a60a78e509' { 'Windows Vista Home Premium - OEM nonSLP/SBC COA' }
        '6e8fcf66-68c5-418c-89fa-f06143b16e0b' { 'Windows Vista Home Premium - OEM SLP COA' }
        '81aa0262-8f30-43e4-9241-22f2822217f4' { 'Win 7 Home Premium N OEM:COA' }
        '74a9709e-f640-4953-bde9-82bc3ed485e7' { 'Win 7 Home Premium N OEM:NONSLP' }
        '5914ce59-acb5-44e6-80d3-1754adb7e84d' { 'Win 7 Home Premium N OEM:SLP' }
        '9cdfc6db-48e1-4b7f-a5f8-fffacd069068' { 'Win 7 Home Premium N retail' }
        '0699dcce-140d-4188-9670-ba003fe8b05e' { 'Win 7 Home Premium N Retail:TB:Promo WGP Test' }
        'cd631d88-c4ea-4e67-9645-5fc32eb49ad6' { 'Win 7 Home Premium N Retail:TB:Sub WGP Test' }
        '7f9e51f2-473c-4006-80fe-0e1f9d308edb' { 'Win 7 Home Premium N Retail:TB:Trial WGP Test' }
        '99605aab-9ac0-48ce-87c9-6063b2e61736' { 'Win 7 Home Premium N TB:Eval WGP Test' }
        'd0554583-4205-48d5-a914-6306b8e95feb' { 'Windows Vista Home Premium N' }
        'edff41f7-3fa5-4976-8389-4948a5eae7cd' { 'Windows Vista Home Premium N - OEM COA' }
        '4a0e27cd-8332-43cd-94a6-7ac946a20187' { 'Windows Vista Home Premium N - OEM NONSLP' }
        '9e59c27a-45ec-462a-a9c8-1de4cb9db719' { 'Windows Vista Home Premium N - OEM SLP' }
        'b4091953-de7c-466c-a5f9-7097de9a728a' { 'Visual Studio 2010 (MSDN Subscription)' }
        'd769269e-b1f1-437b-9401-2150feeb7780' { 'Longhorn Compute Cluster/Web Edition  - MAK' }
        'f1658734-6bf4-48fe-862b-074740d0e51b' { 'Longhorn CSVLK for DataCenter and Itanium Edition' }
        '8f5c1ee4-4a9b-4fe1-96bd-e9290c5e14d4' { 'Longhorn CSVLK for Standard Server and Enterprise Edition' }
        '625e13e0-7339-461b-a39b-1f2f0317449b' { 'Longhorn CSVLK for Web Server & Compute Cluster' }
        '1c15d2b7-0392-4005-a70a-d4d16a3863d4' { 'Longhorn Datacenter/Itanium Edition - MAK' }
        'da638349-358a-4e04-bdcb-c85c8ea036a9' { 'Longhorn Standard/Enterprise Server - MAK' }
        '18579d00-6c51-4907-a16e-3ba4aa9ba6f7' { 'Windows Vista  - OCUR' }
        '9d3c02dd-bfc9-4c35-b503-58ffaa331950' { 'Windows Vista - CodecPack add-on' }
        'e5513235-e240-4238-8127-505711fe321a' { 'Windows Vista Home Premium - OCUR' }
        '6b9fd964-9c41-45ff-af00-9e7b315e9648' { 'Windows Vista Starter Digital Boost - OEM' }
        'c714e640-80ea-481d-8f9f-c80912bb0a25' { 'Visual Basic 2010 Express (30-day Trial)' }
        'd9687110-da83-4368-b71b-c9e0ffb39bb6' { 'Visual C# 2010 Express (30-day Trial)' }
        '18c1ceb4-2128-46ca-9095-575ad9cfda4c' { 'Visual C++ 2010 Express (30-day Trial)' }
        '7ed4c161-1ac9-4fb9-b7ee-517e16e65cc5' { 'Visual Studio 2010 BETA' }
        'bf560dcd-f174-47ad-bb8d-1af34ab4049a' { 'Visual Studio 2010 Kitty Hawk (30-day Trial)' }
        '98185219-6885-4558-bf16-2e0a99660d61' { 'Visual Studio 2010 Kitty Hawk (60-day Extension)' }
        '0965e4ee-c848-4f3c-992f-d1a8a6c02b0f' { 'Visual Studio 2010 Kitty Hawk (90-day Trial)' }
        'de34d3d6-e365-40d4-b76c-d42eadb0af7c' { 'Visual Studio 2010 Lab Management (90-day Trial)' }
        'cc5a0ed0-9ee7-4f2c-8a5b-2b817f84ec70' { 'Visual Studio 2010 Professional (30-day Trial)' }
        'e887e799-ef3f-4a9b-8e1a-fe07d6461fef' { 'Visual Studio 2010 Professional (60-day Extension)' }
        '07870c45-2f34-4101-9c30-2aad980387a1' { 'Visual Studio 2010 Professional (90-day Trial)' }
        '1f8ecf3a-1238-4ec5-a62b-c4689ebd78ff' { 'Visual Studio 2010 Team Essentials (30-day Trial)' }
        '261d81e9-6c21-423f-bcc2-590897fbf3d4' { 'Visual Studio 2010 Team Essentials (60-day Extension)' }
        'fa3926d0-c824-45a8-a462-72d6c275ae5a' { 'Visual Studio 2010 Team Essentials (90-day Trial)' }
        'c1655ff3-a27c-41c8-b257-50045de54de8' { 'Visual Studio 2010 Team Foundation Server (30-day Extension)' }
        '292f44ac-3db8-4dca-ba4e-b1d8f576909e' { 'Visual Studio 2010 Team Foundation Server (90-day Trial)' }
        '89caa0c7-8588-431b-8e21-6d649427554a' { 'Visual Studio 2010 Team Foundation Server Essentials (90-day Trial)' }
        '854d2e9a-88d1-437c-9966-9ed77d40a779' { 'Visual Studio 2010 Team Suite (30-day Trial)' }
        '97e3b845-22b6-4af5-a60b-59e299018d99' { 'Visual Studio 2010 Team Suite (60-day Extension)' }
        'ee6698c1-7288-4275-bd28-3524f1177f44' { 'Visual Studio 2010 Team Suite (90-day Trial)' }
        '6c4cc7a2-c3eb-437c-8d8c-2d3bf2ba3055' { 'Visual Studio 2010 Test Essentials (90-day Trial)' }
        'bb8f7272-a035-4a66-9095-41d0ce27858e' { 'Visual Web Developer 2010 Express (30-day Trial)' }
        'fd8f859a-bb37-4928-bec1-2e7a2e8d9e4b' { 'Win 7 OCUR Ultimate retail' }
        'eb94e158-b4a5-4a2d-b3c4-02ae4772b9db' { 'Visual Studio 2010 Express (OEM)' }
        'd0dd7737-a427-4fee-8f6c-34387607dd84' { 'Visual Studio 2010 Kitty Hawk (OEM)' }
        '9631bf3a-9d4d-46d4-bf38-25815c9b0950' { 'Visual Studio 2010 Professional (OEM)' }
        'd221aa1b-9c71-4148-bf6c-a490446efa99' { 'Visual Studio 2010 Team Essentials (OEM)' }
        '8D1E5912-B904-40A6-ADDD-8C7482879E87' { 'RTM_ProPlusSub_Subscription2' }
        'e82290ba-62b0-41be-89af-cc3f8957125e' { 'Longhorn Compute Cluster' }
        '8372b47d-5221-41d8-88d0-3f924e50623e' { 'Longhorn Compute Cluster - GVLK' }
        '3a51fb61-1f52-48bd-ab74-782599836f89' { 'Longhorn Compute Cluster - OEM COA' }
        '8ad3e8d5-ef2b-427f-a761-a5bfaee2e54d' { 'Longhorn Compute Cluster - OEM NONSLP' }
        '9ce5fa82-900d-4242-95d3-62b6b7325fd4' { 'Longhorn Compute Cluster - OEM SLP' }
        'd01edb83-a9cd-4219-8c42-460d5cc085ef' { 'Longhorn Datacenter Server' }
        '932ef1f5-4327-4548-b147-51b0f5502995' { 'Longhorn Datacenter Server  - GVLK' }
        'fe1c2736-507b-4b90-a739-15d2b9b03990' { 'Longhorn Datacenter Server - OEM nonSLP/SBC COA' }
        '364e4f73-fdca-4947-a509-30b8438270c1' { 'Longhorn Datacenter Server - OEM SLP Bypass' }
        'a7ebbb8f-8fee-4de9-a4cf-53bc962c01d0' { 'Longhorn Datacenter Server - OEM SLP COA' }
        'cc64c548-1867-4777-a1cc-0022691bc2a0' { 'Win 7 Server Datacenter GVLK' }
        '796f16f7-005f-4b6d-a00b-5793bd540439' { 'Win 7 Server Datacenter OEM:COA' }
        'e15b466d-0aa6-476e-a39f-ee80c509ecec' { 'Win 7 Server Datacenter OEM:NONSLP' }
        '7dcb3983-b669-4a79-9cd4-fbd947470d4e' { 'Win 7 Server Datacenter OEM:SLP' }
        'bd1c773d-85fe-4ac2-8ee8-ef75d062e7e9' { 'Win 7 Server Datacenter retail' }
        'a22f7e88-6756-4d82-b9e0-ae8af25cd8c6' { 'Win 7 Server Datacenter Retail:TB:Eval WGP Test' }
        '53a2827d-9705-4667-818b-ee1fb116c1b8' { 'Win 7 Server Datacenter Retail:TB:Promo WGP Test' }
        '5b909dd9-bb92-4d79-bb28-c74589297a0a' { 'Win 7 Server Datacenter Retail:TB:Sub WGP Test' }
        '92a577f4-a7a8-4e9f-8873-aa4f1d481373' { 'Win 7 Server Datacenter Retail:TB:Trial WGP Test' }
        'fed62577-3bef-4309-90e8-671abdc076d8' { 'Win 7 Server Datacenter & Itanium CSVLK' }
        'cd007b25-446b-4524-9c4a-a718d59c5685' { 'Win 7 Server Datacenter & Itanium MAK' }
        'f6aa2373-262b-4716-ae42-8fd847bd3ef3' { 'Longhorn Datacenter Server without Hyper-V' }
        '0839e017-cfef-4ac6-a97e-ed2ea7962787' { 'Win 7 Server Datacenter w\o Hyper V GVLK' }
        '401440ab-6db1-4a9f-b2a3-c5692584634a' { 'Win 7 Server Datacenter w\o Hyper V OEM:COA' }
        'f97932bc-86b1-4ebf-87c6-99320a968b30' { 'Win 7 Server Datacenter w\o Hyper V OEM:NONSLP' }
        '392e0471-9ab8-4a82-875a-a14fe0d74b23' { 'Win 7 Server Datacenter w\o Hyper V OEM:SLP' }
        'f1721f06-97b5-4cc3-a0f3-aad8cb8f30a5' { 'Win 7 Server Datacenter w\o Hyper V retail' }
        '5a99526c-1c09-4481-80fb-b60e8b3d99f8' { 'Longhorn Enterprise Server - GVLK' }
        '9fa561f6-0230-4cd3-9f60-176ccc8961be' { 'Longhorn Enterprise Server - OEM nonSLP/SBC COA' }
        '4c5d3c79-122f-428e-a55c-45f6d1654247' { 'Longhorn Enterprise Server (ADS) - OEM SLP Bypass' }
        'e2668a94-212e-4992-aac8-1298cd4aedaf' { 'Longhorn Enterprise Server (ADS) - OEM SLP COA' }
        '9dce1f29-bb10-4be0-8027-35b953dd46d5' { 'Win 7 Server Enterprise GVLK' }
        '590fe64a-9589-4810-b1d4-08e620cd8754' { 'Win 7 Server Enterprise OEM:COA' }
        '8e62e389-e90c-4b4d-9d1a-6efd7670266c' { 'Win 7 Server Enterprise OEM:NONSLP' }
        '1aecfe30-0e16-42bb-8833-fb73e94f4658' { 'Win 7 Server Enterprise OEM:SLP' }
        'e59bb802-cc40-4d0c-9a8c-73156fea028f' { 'Win 7 Server Enterprise retail' }
        'aa2c9c57-5b58-4c92-a056-dc6bfb76e2b3' { 'Win 7 Server Enterprise Retail:TB:Eval WGP Test' }
        '04f5af3c-49b1-410a-977d-d77ec90101e3' { 'Win 7 Server Enterprise Retail:TB:Promo WGP Test' }
        '863f92ee-262a-4b5b-a0e1-534f537b78f3' { 'Win 7 Server Enterprise Retail:TB:Sub WGP Test' }
        '69349883-84f7-44b0-bbda-0b65c9ea2d97' { 'Win 7 Server Enterprise Retail:TB:Trial WGP Test' }
        'f00d81ce-df2c-47cb-a359-36d652296e56' { 'Windows Longhorn Server Enterprise' }
        '515ad9e6-67a8-4224-8c68-6d073038d59f' { 'Win 7 Server Standard & Enterprise CSVLK' }
        'b93651cc-4b94-41de-8ae2-62f7cfc20b1a' { 'Longhorn Enterprise Server - IA64' }
        '0c5c8ade-0f10-40fe-9a29-fb714e9b921e' { 'Longhorn Enterprise Server - IA64 - OEM SLP Bypass' }
        '61e091dd-1975-4708-8a9b-698bae44ced6' { 'Longhorn Enterprise Server - IA64 - OEM SLP COA' }
        'bebf03b1-a184-4c5e-9103-88af08055e68' { 'Longhorn Enterprise Server - IA64 GVLK' }
        '7360c111-bef4-4462-becc-1b6f623f957d' { 'Longhorn Enterprise Server IA64 - OEM nonSLP/SBC COA' }
        'bf9eda2f-74cc-4ba3-8967-cde30f18c230' { 'Win 7 Server Enterprise IA64 GVLK' }
        '7cdeac17-3dd2-47c6-bcf9-b4b204dde672' { 'Win 7 Server Enterprise IA64 OEM:COA' }
        '052d0def-2551-4e0e-9c91-627c5ac56810' { 'Win 7 Server Enterprise IA64 OEM:NONSLP' }
        '8301f47c-3722-4afd-b9ca-faef693e892c' { 'Win 7 Server Enterprise IA64 OEM:SLP' }
        'c2d22702-a158-4797-af47-a90ba4b57823' { 'Win 7 Server Enterprise IA64 retail' }
        '4954fa71-195f-441e-ac6e-59fc14417898' { 'Win 7 Server EnterpriseIA64 Retail:TB:Eval WGP Test' }
        '5d7e9754-703d-4ee9-a28c-6b748746a49e' { 'Win 7 Server EnterpriseIA64 Retail:TB:Promo WGP Test' }
        '7551a7ce-5545-4cc2-88c9-b6df835d1e37' { 'Win 7 Server EnterpriseIA64 Retail:TB:Sub WGP Test' }
        '257b8450-1ef8-4f32-aec8-ca84b0640db2' { 'Win 7 Server EnterpriseIA64 Retail:TB:Trial WGP Test\' }
        'dc06c019-b222-4706-a820-645e77d26a91' { 'Win 7 Server Enterprise w\o Hyper V GVLK' }
        '24e864f7-0252-4a66-ae91-75768cf14b3b' { 'Win 7 Server Enterprise w\o Hyper V OEM:COA' }
        '89b9bb9f-b4f5-49aa-8bab-29650ad0efee' { 'Win 7 Server Enterprise w\o Hyper V OEM:NONSLOP' }
        '5b216061-dba7-4e96-b8a7-76f1bfe032dc' { 'Win 7 Server Enterprise w\o Hyper V OEM:SLP' }
        'f5bdc9c8-8067-4cba-b28d-06376a78c34e' { 'Win 7 Server Enterprise w\o Hyper V retail' }
        'c745d3ba-1471-4b99-8951-17528ee25aef' { 'Windows Longhorn Server Enterprise without Hyper-V' }
        'a96f6f41-34e8-47ab-9ca1-3749d3776f21' { 'Longhorn Home Server' }
        '495e1b35-670b-4449-902b-a16fc2a9c0a8' { 'Longhorn Home Server - OEM SLP Bypass' }
        'aee7b4de-98dc-4e93-999f-041035637c9c' { 'Longhorn Home Server - OEM SLP COA' }
        '26186aee-5833-4d48-b59d-a1a29c8cbc2d' { 'Win 7 Home Server Premium' }
        'b4b3dccb-b321-4393-8123-3659ec75a192' { 'Win 7 Home Server Premium' }
        '5cb0425f-a4d4-4d4a-8b5f-9ceb4211b322' { 'Win 7 Home Server Premium - OEM NONSLP' }
        'e40d338b-76d2-4755-a8a0-b530d9d970bc' { 'Win 7 Home Server Premium - OEM SLP' }
        '79295998-90ab-4eb2-a093-073ac441006f' { 'Win 7 Home Server Premium - OEM SLP COA' }
        '13d1b96c-1375-43a4-99e7-7e7fefe21f53' { 'Win 7 Home Server Standard' }
        '6a8ed375-e507-49d7-9b38-1623b8e6ff0c' { 'Win 7 Home Server Standard' }
        '725a3567-0181-498f-be72-31741bf08070' { 'Win 7 Home Server Standard - OEM NONSLP' }
        '3b18e76c-2384-4029-a596-c939c91cb7be' { 'Win 7 Home Server Standard - OEM SLP' }
        '0d621b72-d593-4e42-bbab-1911c7326549' { 'Win 7 Home Server Standard - OEM SLP COA' }
        'b2ce91d8-d515-41a6-b04c-4a13768f7cc5' { 'Hyper-V ProdAct All Programs' }
        '734ec80d-44e4-40c6-b6cd-a0acb3ca8421' { 'Longhorn Medium Business Server Management - OEM SLP Bypass' }
        '658d9331-fcf8-4eee-8256-7ba65c58cbbe' { 'Longhorn Medium Business Server Management - OEM SLP COA' }
        '41d2d873-0ebb-4346-bf27-3389616e86d3' { 'Win 7 Server Medium Business Management retail' }
        'b86971e5-2264-43c4-ad85-acec5fc78d1c' { 'Longhorn Medium Business Server Messaging - OEM SLP Bypass' }
        '1dc5fe8c-65a6-42e0-9778-7510abef2f2b' { 'Longhorn Medium Business Server Messaging - OEM SLP COA' }
        '31f395ce-fc28-4a33-b676-81b109902ee8' { 'Win 7 Server Medium Business Messaging retail' }
        '2cade295-51c0-4718-b89f-2e8944003d26' { 'Longhorn Medium Business Server Security - OEM SLP Bypass' }
        '0b7d7918-8b22-49ef-9cd0-4f04bfde5c99' { 'Longhorn Medium Business Server Security - OEM SLP COA' }
        '31ac603c-0483-4db9-8006-1831517ae142' { 'Win 7 Server Medium Business Security retail' }
        'b0593bb3-f0cf-4967-a4a5-53af84c6d29b' { 'Longhorn SBS Premium - OEM SLP Bypass' }
        'a8c7a60d-a1a5-4390-957c-ebec9e8b1a24' { 'Longhorn SBS Premium - OEM SLP COA' }
        'ae486542-39df-4ec8-8483-ac502f5eed7f' { 'Win 7 Server SBS Premium retail' }
        '6e95e93f-2b94-4c3d-80e5-360f6bd162fb' { 'Longhorn SBS Prime' }
        '0bdbb717-9a8e-449b-b57d-763decd05c2a' { 'Longhorn SBS Prime - OEM SLP Bypass' }
        'd6670835-2583-4c5f-a147-4ebdef90c962' { 'Longhorn SBS Prime - OEM SLP COA' }
        '6c5ed930-475f-4b67-a7db-19205ee419ca' { 'Longhorn SBS Standard - OEM SLP Bypass' }
        '4c8a4ef8-77a1-4820-93ed-48e55909e37b' { 'Longhorn SBS Standard - OEM SLP COA' }
        '2bb92f71-6ab3-473b-a024-cd29226ca236' { 'Win 7 Server SBS Standard retail' }
        '61d6a4f0-3285-4ea8-a9de-f938b973a0ec' { 'Longhorn Standard Server ' }
        '7ea4f647-9e67-453b-a7ba-56f7102afde2' { 'Longhorn Standard Server  - GVLK' }
        'c2c3c743-bcfe-40c8-82e4-ed335c53a86c' { 'Longhorn Standard Server  - OEM SLP Bypass' }
        '3c805a06-632e-451e-a8ea-80a0b084fbb5' { 'Longhorn Standard Server  - OEM SLP COA' }
        '79d3bf31-319f-49f9-aa02-7e40332b0644' { 'Longhorn Standard Server - OEM nonSLP/SBC COA' }
        '92374131-ed4c-4d1b-846a-32f43c3eb90d' { 'Win 7 Server Standard GVLK' }
        '7b842e94-24f3-47bd-bce1-26ce97fdc2f5' { 'Win 7 Server Standard OEM:COA' }
        'a03cd2a1-d4f0-4372-aa0e-f67a951780d0' { 'Win 7 Server Standard OEM:NONSLP' }
        '3fecd780-e58a-4d0a-a43e-76d48def79e7' { 'Win 7 Server Standard OEM:SLP' }
        '6511a970-90d0-40ed-92e9-6ce344996f0c' { 'Win 7 Server Standard retail' }
        '427a2c12-f067-4cdd-ae14-702c3f273923' { 'Win 7 Server Standard Retail:TB:Eval WGP Test' }
        'b59b3573-2b81-413f-8f6d-df8ebcf8695d' { 'Win 7 Server Standard Retail:TB:Promo WGP Test' }
        'abe80861-21cc-4629-9a15-4030ff149a86' { 'Win 7 Server Standard Retail:TB:Sub WGP Test' }
        '647393cf-89a6-4f0b-bb99-172540e4fb37' { 'Win 7 Server Standard Retail:TB:Trial WGP Test' }
        'b3e628a2-fb9c-417d-93d3-289eed1e81c2' { 'Win 7 Server Standard & Enterprise MAK' }
        '18135975-c710-41d2-b6fa-3775340f1ae1' { 'Longhorn Standard Server without Hyper-V' }
        'f963bf4b-9693-46e6-9d9d-09c73eaa2b60' { 'Win 7 Server Standard w\o Hyper V GVLK' }
        'caa217f0-0375-45d4-8be1-5967246b097e' { 'Win 7 Server Standard w\o Hyper V OEM:COA' }
        'c78f3a14-d8e9-4dca-8691-ccbdf5f7eaf0' { 'Win 7 Server Standard w\o Hyper V OEM:NONSLP' }
        'b2ca342c-f521-4d36-b899-cf5db346a081' { 'Win 7 Server Standard w\o Hyper V OEM:SLP' }
        '32120bb0-2f3c-4aca-b5ca-f06194f2c34c' { 'Win 7 Server Standard w\o Hyper V retail' }
        'f97270ab-1ff1-41d1-bc63-829558ff4230' { 'Longhorn Storage Server - Enterprise OEM SLP Bypass' }
        '13136377-e3a6-4c94-9cb6-121b91ae9ecb' { 'Longhorn Storage Server - Enterprise OEM SLP COA' }
        'b510fd83-c941-47e3-b3c1-b6b8785d77ee' { 'Win 7 Server Storage Enterprise retail' }
        '1fa6b5e0-eceb-4693-ac2d-a33b3c9f05e9' { 'Windows Storage Server Enterprise OEM:COA' }
        'd5224a3d-38d5-456a-8384-84e0b39be105' { 'Windows Storage Server Enterprise OEM:NONSLP' }
        '51af4918-f017-487c-9cea-70041577d4b8' { 'Windows Storage Server Enterprise OEM:SLP' }
        'f97038e5-4593-40bd-b83a-d5d9efaf7b07' { 'Longhorn Storage Server - Express OEM SLP Bypass' }
        'e599e19b-4973-4b16-a71b-bc6beb3f65f6' { 'Longhorn Storage Server - Express OEM SLP COA' }
        '9f9a3e71-f510-4bc0-b87d-25f43cd43b2e' { 'Win 7 Server Storage Express retail' }
        '3373a73b-8376-41a6-a099-d19fca0ccd70' { 'Windows Storage Server Express OEM:COA' }
        '1a113027-5c6f-46a5-8567-451f2b1155ad' { 'Windows Storage Server Express OEM:NONSLP' }
        'fcd2462a-64f8-4516-b417-2f4845a4809b' { 'Windows Storage Server Express OEM:SLP' }
        'cb3029c5-a33a-4311-b46c-673a628226b1' { 'Longhorn Storage Server - Standard OEM SLP Bypass' }
        '9c216ebe-48ee-42ad-a0c1-bbb95ac7166f' { 'Longhorn Storage Server - Standard OEM SLP COA' }
        '320c5bda-6cab-4736-a827-789d8390b041' { 'Win 7 Server Storage Standard retail' }
        '0a6fcbd1-bcfe-4084-b96e-11abc23cbb1d' { 'Windows Storage Server Standard OEM:COA' }
        '5c28538a-730c-43c6-a278-ad450c927903' { 'Windows Storage Server Standard OEM:NONSLP' }
        'b14681a9-dba0-4512-aaa4-0500332f2823' { 'Windows Storage Server Standard OEM:SLP' }
        'd3e56435-0e1b-46c6-b62f-7b602e1b24ed' { 'Longhorn Storage Server - Workgroup OEM SLP Bypass' }
        '74be6fe2-3d15-4a1d-8413-e6ee21f6d655' { 'Longhorn Storage Server - Workgroup OEM SLP COA' }
        'ef7eccdc-7353-4b44-a153-57c767af0bcf' { 'Win 7 Server Storage Workgroup retail' }
        '8affafda-4ba1-446c-b4fc-d55495dabadd' { 'Windows Storage Server Workgroup OEM:COA' }
        'd61ce74c-00a6-4bdf-9a16-ebe868fe12b7' { 'Windows Storage Server Workgroup OEM:NONSLP' }
        'f1949a7a-1c7b-4486-abbb-98fe7feb166e' { 'Windows Storage Server Workgroup OEM:SLP' }
        '2e3108b4-de27-4d71-8a59-ed6fa329f519' { 'Longhorn Web Edition' }
        '3ddb92aa-332e-46f9-abb7-8bdf62f8d967' { 'Longhorn Web Edition - GVLK' }
        'a407b19d-68d6-47f3-8e8a-1c0d1df29ad0' { 'Longhorn Web Edition - OEM COA' }
        'd56e10e1-8373-48ef-98c2-25e2b9fb17a9' { 'Longhorn Web Edition - OEM NONSLP' }
        'bf5920fb-e20b-4f08-b9d9-90f3d26f6641' { 'Longhorn Web Edition - OEM SLP' }
        '95e4a692-f166-45c5-a7f8-ad76c2c1e6ad' { 'Win 7 Server Web (no CC) CSVLK' }
        '389c4be7-a87b-43c0-8338-e4eba79ccd96' { 'Win 7 Server Web (no CC) MAK' }
        '4f4cfa6c-76d8-49f5-9c41-0a57f8af1bbc' { 'Win 7 Server Web GVLK' }
        '69596c32-c0c8-41d7-a33e-2084d5889194' { 'Win 7 Server Web OEM:COA' }
        'c52487db-d92b-4258-865d-ce3c08be8149' { 'Win 7 Server Web OEM:NONSLP' }
        '3f9430a7-ee3a-4b10-be6e-2a1a227952e1' { 'Win 7 Server Web OEM:SLP' }
        '220cd791-4e60-4412-8fcf-d605f54d3ae0' { 'Win 7 Server Web retail' }
        'f3b6a4d0-7f95-4c3f-89dd-2b4a10c5e6f1' { 'Win 7 Server Web Retail:TB:Eval WGP Test' }
        'a3099af4-2d1e-4ddc-980c-b1dabd269456' { 'Win 7 Server Web Retail:TB:Promo WGP Test' }
        '24e0f8b5-037c-4a8d-8e1c-9de1ae2bdff1' { 'Win 7 Server Web Retail:TB:Sub WGP Test' }
        '528492be-3314-430d-8162-5ab9739bb5c2' { 'Win 7 Server Web Retail:TB:Trial WGP Test' }
        '17df1098-8f00-46a3-b3e7-f0c77553ba40' { 'Win 7 Server Web & HPC Volume:BA_A' }
        '74ee1811-ebbb-4c84-93df-f274d5ecdf00' { 'Win 7 Server Standard & Enterprise Volume:BA_B' }
        '3d3a0fe2-fa84-4623-b214-ad01cb83e930' { 'Win 7 Server Datacenter & EnterpriseIA64 Volume:BA_C' }
        '7d481b79-8e06-4722-b9d6-b13c8bc800b8' { 'Longhorn Server for Small Business' }
        'de0a1b88-376e-4ee0-9975-a46b2ec18aa4' { 'Longhorn Server for Small Business - OEM SLP Bypass' }
        '04bcfa8f-fb66-4d42-98a1-ab3d27108dd3' { 'Longhorn Server for Small Business - OEM SLP COA' }
        '97a60026-ca3d-4fd2-a454-9e1a4831164a' { 'Longhorn Server for Small Business without Hyper-V' }
        'e38db88f-2a62-4b38-a6f1-c69c8717fc72' { 'Win 7 Starter OEM:COA' }
        'c1a40325-318f-475a-998d-f84807c5ed59' { 'Win 7 Starter OEM:NONSLP' }
        '27d8421c-7335-46d6-93ad-646d33541a6c' { 'Win 7 Starter OEM:SLP' }
        '86058316-c74b-4e6a-bb20-5bdfd34314b5' { 'Win 7 Starter retail' }
        'f18e15a5-d5b4-45ae-89a7-263c443b34c3' { 'Win 7 Starter Retail:TB:Promo WGP Test' }
        'ce194785-7f23-4be5-bd19-169fc3bf6cc3' { 'Win 7 Starter Retail:TB:Sub WGP Test' }
        'c729fded-1fed-4bed-b4c6-5ea5e9832836' { 'Win 7 Starter Retail:TB:Trial WGP Test' }
        'e20068ea-d533-4836-a89c-77fdc9995c4a' { 'Win 7 Starter TB:Eval WGP Test' }
        '2ba44e77-c7b8-48f3-8e51-284b35493fae' { 'Windows Vista Starter' }
        '379474f4-1cf9-44a8-999c-f68ef14bfe49' { 'Windows Vista Starter - OEM nonSLP/SBC COA' }
        '889d40d1-491a-4237-80f3-ef4b1f9c6845' { 'Windows Vista Starter - OEM SLP Bypass' }
        '6e5a3ef9-5d24-4b43-a292-eb5b72a18094' { 'Windows Vista Starter - OEM SLP COA' }
        'b4a8e32a-9757-45d1-8ece-28a6b21b4c47' { 'Win 7 Starter N retail' }
        '6cd32042-49da-4634-bd02-448fbe76bfbe' { 'PK3 Windows Embedded Standard 8 00140 DLA/Bypass Retail Toolkit' }
        '2b03f08f-1014-469C-8f73-07ff8b68399c' { 'PUP-DL Vista Ultimate upg from Vista Business' }
        'f51fef5d-3efa-4351-a63f-af7a9ff383c0' { 'PUP-DL Vista Ultimate upg from Vista Home Basic' }
        'b58078be-9c9a-48c9-b5ef-d920fd76218d' { 'PUP-DL Vista Ultimate upg from Vista Home Premium' }
        'f792792d-4d26-43f3-a568-8e0d98cd622c' { 'Win 7 Ultimate OEM:COA' }
        'ae3800b9-bb05-4a4c-9d5e-1e25cd26975f' { 'Win 7 Ultimate OEM:NONSLP' }
        '2077f0b2-b2e2-43c5-a3b2-2079d527f56a' { 'Win 7 Ultimate OEM:SLP' }
        'bfb30674-7c9a-4624-9309-9914cfd5b05c' { 'Win 7 Ultimate retail' }
        'e07989ff-9cc4-450c-8a0c-ffe9f7bfa57d' { 'Win 7 Ultimate Retail:TB:Promo WGP Test' }
        '7f99509a-a8af-4839-a031-f36adc209a57' { 'Win 7 Ultimate Retail:TB:Sub WGP Test' }
        '2b117cfd-aed1-475e-b68f-d0c06ca9c4e8' { 'Win 7 Ultimate Retail:TB:Trial WGP Test' }
        'e5903ef0-5584-484f-9e33-c1dc48ed160c' { 'Win 7 Ultimate TB:Eval WGP Test' }
        '93e4d97f-9aec-45f9-8eb8-f7f3b67bf400' { 'Windows Vista Ultimate' }
        'de614ff4-3407-49c0-a9b7-3594d96a47e5' { 'Windows Vista Ultimate - MAK' }
        '7a7a77b8-8ed9-456e-8d0f-d1b743e5730c' { 'Windows Vista Ultimate - OEM nonSLP/SBC COA' }
        '76ff6e22-06ce-4340-b386-2b2f6c5a6e77' { 'Windows Vista Ultimate - OEM SLP COA' }
        'b6633b14-5f98-454c-9301-74c016ece289' { 'Win 7 Ultimate N OEM:COA' }
        '7f8c9783-8cf4-406a-9fd9-69dfb5406c1d' { 'Win 7 Ultimate N OEM:NONSLP' }
        '21d9b582-cf0c-4c49-823d-d8150b4ee1ef' { 'Win 7 Ultimate N OEM:SLP' }
        '09fa3538-63aa-427a-bc2a-4be28ccf4f60' { 'Win 7 Ultimate N retail' }
        '226108e7-746d-47d3-8dd7-8272a4277840' { 'Windows Vista Ultimate N' }
        '67bbc59a-06a9-4740-9451-ba9cb7bbdcb9' { 'Windows Vista Ultimate N - OEM COA' }
        'c2b40cd9-71a1-4a6d-8680-a92f2db68b87' { 'Windows Vista Ultimate N - OEM NONSLP' }
        'a0f37727-3001-4ee3-91f0-7da289402961' { 'Windows Vista Ultimate N - OEM SLP' }
        '6038b894-745c-4f41-b1d3-8a4d2d4e84d9' { 'Visual Studio 2010 Kitty Hawk (Volume License)' }
        '4ada16ad-5428-4610-8dad-0af9cecb7d89' { 'Visual Studio 2010 Lab Management (Volume License)' }
        '5af31552-1e2f-4d45-9976-2ff240ca3daa' { 'Visual Studio 2010 Professional (Volume License)' }
        'a2af668b-67fd-4ff6-b3da-987185d38929' { 'Visual Studio 2010 Team Essentials (Volume License)' }
        '48a9a1fd-ada2-4be9-95fe-647e12cfd745' { 'Visual Studio 2010 Team Foundation Server (Volume License)' }
        '52947ec0-8154-4f23-b345-ba944e1b82ff' { 'Visual Studio 2010 Team Foundation Server Essentials (Volume License)' }
        'fa936247-5df1-4599-b765-0535e289893b' { 'Visual Studio 2010 Team Suite (Volume License)' }
        'ca00e817-3bae-4de3-a6ec-86e447949b8b' { 'Visual Studio 2010 Test Essentials (Volume License)' }
        'f397e5c5-234e-4e81-9fd7-710a0bf43b61' { 'Visual Studio 2010 Test Load Agent Controller (Retail 10k pack)' }
        '931aeefe-da83-4f09-83e1-ba9a64491fa0' { 'Visual Studio 2010 Test Load Agent Controller (Retail 1k pack)' }
        '93b64ee9-40ac-4662-ace1-679689b28b33' { 'Visual Studio 2010 Test Load Agent Controller (Volume 10K pack)' }
        '497ab398-a644-4326-9867-93cc4fc08079' { 'Visual Studio 2010 Test Load Agent Controller (Volume 1K pack)' }
        '3332f1f9-d8f5-4e2e-b0f6-a6f7d97e7706' { 'Visual Studio 2010 Test Load Agent Controller (Volume 2.5K pack)' }
        'd4ccfed7-16e8-4499-a921-187e0e471761' { 'Visual Studio 2010 Test Load Agent Controller (Volume 500 pack)' }
        'e25b8b0d-3fa6-43d3-9bd7-4679e0523cf3' { 'Visual Studio 2010 Test Load Agent Controller (Volume 5K pack)' }
        '04b2ddca-4cba-4cf3-9f76-c88adddcbb06' { 'Visual Studio 2010 Test Load Agent Controller (Volume Unlimited pack)' }
        '4f3d1606-3fea-4c01-be3c-8d671c401e3b' { 'Windows Vista Business' }
        '9de9abe2-d01d-4538-af84-4498bdbc2ba3' { 'Windows Vista Business Retail' }
        '2d2d5664-88bd-4ebc-959a-dea6b1b80dc0' { 'Windows Vista SP2 Business OEM:COA' }
        '212a64dc-43b1-4d3d-a30c-2fc69d2095c6' { 'Windows Vista ALL Volume SKUs - CSVLK' }
        '74e464f6-45db-41f6-9356-66260bdf3c65' { 'Windows Vista ALL Volume SKUs - MAK' }
        '2c682dc2-8b68-4f63-a165-ae291d4cf138' { 'Windows Vista BusinessN' }
        'db442be4-81ed-4ab3-9d66-2417e8a5c81c' { 'Windows Vista Business N Retail' }
        '95a6eef2-89d4-4759-b65b-0a0748994b82' { 'Windows Vista CODEC add-on Retail' }
        'cfd8ff08-c0d7-452b-9f60-ef5c70c32094' { 'Windows Vista Enterprise' }
        'b51791c2-b562-4b73-97b0-735a0e4429a6' { 'Windows Vista Enterprise Retail' }
        '58c37517-42f8-4723-bb44-30b05791ff2a' { 'Windows Vista EnterpriseN  Retail' }
        'd4f54950-26f2-4fb4-ba21-ffab16afcade' { 'Windows Vista EnterpriseN' }
        '95c6e80a-0ff8-4bd0-95f2-c4a39b79d09e' { 'Windows Vista Home Basic Retail' }
        'acc41c6f-dc9f-40ca-b0da-108c7a5f8d90' { 'Windows Vista SP2 Home Basic OEM:COA' }
        'd0333dad-c14e-46f2-b62a-8b47a1b9768b' { 'Windows Vista Home Basic N Retail' }
        '9e042223-03bf-49ae-808f-ff37f128d40d' { 'Windows Vista Home Premium Retail' }
        '92d8977c-d506-4e63-b500-6d39283b6cd5' { 'Windows Vista Home Premium N Retail' }
        'afd5f68f-b70f-4000-a21d-28dbc8be8b07' { 'Windows Vista OCUR add-on Retail' }
        'e0872c5d-9308-4c2a-ba9b-22f04a9b9480' { 'Windows Vista SP2 Starter OEM:NONSLP' }
        '70453a75-42cb-49ba-83d8-d9dc6295901b' { 'Windows Vista Starter Retail' }
        '136595fa-543f-4a64-8326-873935b7b7a1' { 'Windows Vista SP2 Ultimate OEM:NONSLP' }
        '30fab9cc-8614-4339-989f-7ce61fb7a5c4' { 'Windows Vista Ultimate Retail' }
        '1eefed20-8ac0-478c-8774-70cd44782ea1' { 'Windows Vista Ultimate N Retail' }
        'f758e09b-7c7c-492c-b78c-aba5bd4e3f5b' { 'Windows Vista Business - OEM:COA' }
        'e8d89889-a417-408a-8180-02a89339580d' { 'Windows Vista Business N OEM:COA' }
        '91dbad68-4713-4f9c-b351-6e77a8361741' { 'Windows Vista Home Basic - OEM:COA' }
        '9c5c23f2-a6c3-4c6c-b9b4-1f8796b63254' { 'Windows Vista Home Basic N OEM:COA' }
        'a4eec485-e375-48b4-8f51-80d13a4086b6' { 'Windows Vista Home Premium - OEM:COA' }
        '94451d5d-8520-43d3-af38-4e54d817a407' { 'Windows Vista Starter - OEM:COA' }
        'f79b5e33-4a4e-451c-9e8a-55dcc9bdb89d' { 'Windows Vista Ultimate - OEM:COA' }
        'f14a0fcc-9198-49d0-9b48-61398a545aae' { 'Windows Vista Business - D-OEM (CHS & RU) OEM:NONSLP' }
        '177df7ed-709f-454a-91bd-947ec8a1e668' { 'Windows Vista Business - OEM:NONSLP' }
        'fd3bcb98-5c55-4b2d-ae32-a4515e3c17a3' { 'Windows Vista Business - OEM:SLP' }
        '24a6d36e-9110-4081-bec6-fa27c8e860d0' { 'Windows Vista SP2 Home Business Retail' }
        'fdc08872-563e-4e3a-ad19-981c2c58b4d9' { 'Windows Vista Business N OEM:NONSLP' }
        '92bc39aa-055e-4919-adca-763fcde047b8' { 'Windows Vista Business N OEM:SLP' }
        'd584adf1-69e1-4710-98a3-89f37b940020' { 'Windows Vista Enterprise - OEM:SLP' }
        '26241618-ffd9-4440-af04-2ab852b2767f' { 'Windows Vista Home Basic - D-OEM (CHS & RU) OEM:NONSLP' }
        'bb4c2c10-dc0d-4ce6-8824-ee71ddb63c07' { 'Windows Vista Home Basic - OEM:NONSLP' }
        '199086aa-6cb8-4e5b-b698-f2be56f1e8ee' { 'Windows Vista Home Basic - OEM:SLP' }
        '5f44767a-daac-470f-8e93-294b3217f956' { 'Windows Vista SP2 Home Basic Retail' }
        '827661ef-a4de-4110-9b8a-4c7fdc42dc89' { 'Windows Vista Home Basic N OEM:NONSLP' }
        '9680dca9-c58d-4f58-817e-ff16ffc626c8' { 'Windows Vista Home Basic N OEM:SLP' }
        'b6795467-dc45-4acf-af87-e948ee3f15f4' { 'Windows Home Premium - D-OEM (CHS & RU) OEM:NONSLP' }
        'f3acdd3c-119a-4932-a3d7-0b6f33a1dca9' { 'Windows Vista Home Premium - OEM:NONSLP' }
        'bffdc375-bbd5-499d-8ef1-4f37b61c895f' { 'Windows Vista Home Premium - OEM:SLP' }
        'cdb090c3-053c-4cd1-9cb2-e35b1738747a' { 'Windows Vista SP2 Home Premium Retail' }
        '89e51a3c-76c0-4beb-a650-53d34c8f8186' { 'Windows Vista Starter - OEM:NONSLP' }
        '851f81c4-16c6-4de8-a20a-dcebd6b76c89' { 'Windows Vista Starter - OEM:SLP' }
        '33a7e8d3-e2ab-413b-96a6-27c83b21c695' { 'Windows Vista Ultimate - OEM:NONSLP' }
        '5e802570-4657-4e84-bfbc-6a0e531b84af' { 'Windows Vista Ultimate - OEM:SLP' }
        'c3505bd0-004a-49b9-84db-a1a4869eddf1' { 'Windows Vista Home Premium - OEM:COA' }
        '86e0a073-040b-4e10-aaf1-55f75482b5a4' { 'Windows Vista SP1 Business OEM:NONSLP' }
        '341adbdd-bf38-497d-9676-fc981f6ccc70' { 'ProdKey3 Exchange Svr 2010 00150 DLA ByPass Volume:GVLK Vol Lic Std Coex' }
        'febe415b-b7d4-4aac-a9c6-8cebf4f9d14d' { 'Embedded Standard Retail Acad Edtn OEM' }
        '602a3fcf-02ac-4ef4-975a-57d096cc4d69' { 'Embedded Standard Retail Default Key Evl OEM' }
        'adb4e385-907b-45da-8c1c-cd428e2f9a06' { 'Embedded Standard Retail Prem Edtn Eval OEM' }
        'd49ab3d8-bdf9-45f8-9383-e106831bda60' { 'Embedded Standard Retail Std Edtn Eval OEM' }
        '1d30a37d-c938-48ae-8e77-96686f5ef87f' { 'Embedded Standard Volume:BA Lckd Edtn OEM' }
        'eb788ea6-a0ee-41fd-a238-1a9163b0be0e' { 'Embedded Standard Volume:BA Prem Edtn OEM' }
        'dea43b09-c900-4e4c-a611-999261148089' { 'Embedded Standard Volume:BA SMB Lckd Edtn OEM' }
        '7393f438-73bf-44f0-a954-12edfb724145' { 'Embedded Standard Volume:BA SMB Prem Edtn OEM' }
        '402ad928-b65e-4f1f-859c-0cbd4060ddef' { 'Embedded Standard Volume:BA SMB Std Edtn OEM' }
        'e1a8296a-db37-44d1-8cce-7bc961d59c54' { 'Embedded Standard Volume:BA Std Edtn OEM' }
        '21b48ea2-ba74-49c7-a627-b707ee694f28' { 'ProdKey3 Exchange Svr Ent 2010 00150 DLA/Bypass ByPass Volume:GVLK Vol L' }
        '911e20cb-83ea-44ed-8799-073be1f77f22' { 'Windows Server HPC OEM:COA' }
        '0447e96f-4062-4c1b-b068-98c8326016f2' { 'Windows Server HPC OEM:SLP' }
        '9515b08e-d839-4df3-bfe7-daecde02d97e' { 'Windows Server HPC OEM:SLP' }
        '28169020-83db-42d0-87bb-7709454c5f62' { 'Windows Server 2008 Datacenter OEM:NONSLP' }
        '5762371d-a6fe-4fea-af1b-b9f0367d8e46' { 'Windows Server 2008 Datacenter OEM:SLP' }
        'd020c729-07f0-4f8f-87ce-bf803275c786' { 'Windows Server 2008 Datacenter without Hyper-V OEM:NONSLP' }
        'f209258f-33ca-4a14-a45c-5cafa7259ab5' { 'Windows Server 2008 Datacenter without Hyper-V OEM:SLP' }
        '56cd5000-40b0-4e44-97a7-245191e7dfe3' { 'ServerEmbeddedSolution Retail' }
        '0fe54906-7d56-412b-bab8-4f0cd9e07a2a' { 'ServerEmbeddedSolutionCore Retail' }
        'a6ad72e3-67a6-4d46-af1c-5f542c22ef7c' { 'Windows Server 2008 Enterprise OEM:NONSLP' }
        '94dd1d84-9d70-45ff-ae30-6c1643e583ac' { 'Windows Server 2008 Enterprise OEM:SLP' }
        '256cc990-1692-4ea8-965c-2d423d5dd24e' { 'Windows Server 2008 for Itanium-Based Systems nonSLP' }
        '766d0cf7-accb-4fe9-b9a0-b4bfa8ae7550' { 'Windows Server 2008 for Itanium-Based Systems OEM:SLP' }
        '388afeb9-3b92-44a2-a3dd-1e68665f6d36' { 'Windows Server 2008 Enterprise without Hyper-V OEM:NONSLP' }
        'd063c01b-b1c3-442c-8cc4-4be55a1a01df' { 'Windows Server 2008 Enterprise without Hyper-V OEM:SLP' }
        '20fd891c-4d02-425c-9840-3f762d993737' { 'Server 2008 R2 Essential Business Server "Cascades" OEM:NONSLP' }
        '9534497b-0bba-4fae-bf3d-1a7597eeb188' { 'Server 2008 R2 Essential Business Server "Cascades" OEM:SLP' }
        'e6df6197-1508-45e5-8ddd-3d07b674f5cd' { 'Server 2008 R2 Essential Business Server "Cascades" Retail' }
        '780ac8a3-9312-4077-98a2-dd957cf8b7dc' { 'Server 2008 R2 Essential Business Server "Cascades" Retail TB:Eval' }
        'b3bae0cf-e1a1-4263-b8c8-3fd852b8850a' { 'ServerEBS Essential Additional' }
        '6b43d071-dbe7-472d-8c0f-d33295fcddd6' { 'Server 2008 R2 Essential Business Server (all editions EBS) MAK' }
        '8fcad604-c17b-4620-b073-470555f273d5' { 'Server 2008 R2 Essential Business Server "Klamath" OEM:NONSLP' }
        '4ca3ecfc-432d-43f7-91c5-4d0226a07f41' { 'Server 2008 R2 Essential Business Server "Klamath" OEM:SLP' }
        '72d9dfa0-00bd-4152-8d49-11f16632d9a2' { 'Server 2008 R2 Essential Business Server "Klamath" Retail' }
        '82f26cca-d9f0-4259-be0f-7b86c382eec7' { 'Server 2008 R2 Essential Business Server "Klamath" Retail TB:Eval' }
        '5b522eb9-8288-40eb-aaa9-e3f8b8616042' { 'ServerEBS Essential Additional Svc' }
        '1dbe6f30-a618-4909-ba6e-aa5a66f1e96a' { 'Server 2008 R2 Essential Business Server "Cascades" OEM:NONSLP' }
        '66c86c35-a315-468a-8dfd-b0a36f9d3584' { 'Server 2008 R2 Essential Business Server "Cascades" OEM:SLP' }
        '314d9cd5-b80b-46b9-b7d5-2dc3ae9e807f' { 'Server 2008 R2 Essential Business Server "Cascades" Retail' }
        '161135e2-8a99-42ee-912c-4161e4056d7c' { 'Server 2008 R2 Essential Business Server "Cascades" Retail TB:Eval' }
        '7b6916bb-3b99-40ea-8b2d-5d8f948f2b74' { 'ServerEBS Essential Management' }
        '9a7ceac4-1f33-4e4b-a866-34f00b8a2438' { 'Server 2008 R2 Essential Business Server "Klamath" OEM:NONSLP' }
        '1a07362f-15ee-4af8-a374-75157d6b6fbb' { 'Server 2008 R2 Essential Business Server "Klamath" OEM:SLP' }
        '722105e6-be37-4c48-9a08-4cd6a5e0bd55' { 'Server 2008 R2 Essential Business Server "Klamath" Retail' }
        '29fb0edc-c2fd-413c-a72e-9fe36075c9de' { 'Server 2008 R2 Essential Business Server "Klamath" Retail TB:Eval' }
        '4c853108-8b21-489d-a5c7-c46ea27670a9' { 'ServerEBS Essential Management Svc' }
        '93d59c57-b6e1-4c3d-8caf-204cd102a69a' { 'ServerforSBSolutions Retail' }
        'fa0d7bfa-140f-4ca1-ae5b-e4a666549beb' { 'ServerforSBSolutionsEM Retail' }
        '31d69fd1-8967-417e-9464-59d6ca58190f' { 'Windows Storage Server 2008 R2 Essentials ServerHomeStandard OEM:NONSLP' }
        '07acd797-a4c1-49d2-84a8-c08a14fb83b2' { 'Windows Storage Server 2008 R2 Essentials ServerHomeStandard OEM:SLP' }
        'e267bacf-b3bf-45e5-a2ba-057855b3c59f' { 'Windows Storage Server 2008 R2 Essentials ServerHomeStandard Retail' }
        '59cbe984-9a35-48c2-a471-a437dd1fa8a5' { 'ServerMBS Management' }
        'f4f5e8f4-7a61-40ce-8832-630a6eba038d' { 'ServerMBS Messaging' }
        'a1d8e513-d10f-479e-8963-b9f82c1bfa36' { 'ServerMBS Security' }
        'c0c1f3e8-e9b6-461d-afbf-8f964f4d11c2' { 'ServerSBSPremium  Retail' }
        'de57e6db-74a6-4de2-9b45-6305085bd104' { 'ServerSBSPremium Retail' }
        '6860916b-c83f-4d66-a28c-c6b78499e7d0' { 'Windows Small Business Server Premium Retail' }
        '96fd21ec-7c70-4c04-9fce-b034941c0473' { 'ProdKey3 Windows Server Foundation 00150 ProdAct 10 nonOA II OEM' }
        '9f5cfb3d-6288-4f6f-9d57-fffd843d53e6' { 'ProdKey3 Windows Server Foundation 2008 00150 OEMAct/Preinstall PrePop OA II' }
        '89900d26-c363-4e32-a7a1-c70411a8e539' { 'ServerSBSPrime  Retail' }
        '46aa2e8e-142f-4504-bbdf-921b27c44440' { 'ServerSBSStandard Retail' }
        '58a6435c-0657-4912-b0f5-810215560e47' { 'Windows Small Business Server Standard OEM:NONSLP' }
        'd034a056-e1d5-43e0-9511-7586b6d335eb' { 'Windows Small Business Server Standard OEM:SLP' }
        '0fe34a6c-50a1-4cfb-9013-3fdf51127f04' { 'Windows Small Business Server Standard Retail' }
        'b0d479a0-f524-4da0-ad5f-ead4c2eac5d9' { 'ServerSolution Retail' }
        '5662c706-f571-4c83-9649-3916a56a2b74' { 'Windows Server 2008 R2 for Small Business Server Essentials  ServerSolution OEM:NONSLP' }
        '74e20158-a356-46aa-bb8a-fc200f20a9c2' { 'Windows Server 2008 R2 for Small Business Server Essentials  ServerSolution OEM:SLP' }
        'c8ffd775-fd93-4b7d-b622-20244a71009b' { 'Windows Small Business Server 2011 Essentials ServerSolution Retail' }
        'bdbaaa16-4622-4547-828b-abff92a18218' { 'ServerSolutionEM Retail' }
        '3c2baabd-257f-4f5c-9c3e-e3112a1c939e' { 'ServerSolutionsPremium Retail' }
        '51dc19af-0ddb-4cdf-b6be-3a314f2c4da1' { 'ServerSolutionsPremium Retail' }
        '7acd9eb8-e300-444c-b38a-47cdbe065508' { 'Windows Server 2008 Standard OEM:NONSLP' }
        '15a581b4-f839-4d26-943c-b7e72f219849' { 'Windows Server 2008 Standard OEM:SLP' }
        '2e063f49-6ce7-4099-be9e-8b1c3590f5c8' { 'Windows Server 2008 Standard without Hyper-V OEM:NONSLP' }
        '0e18c71e-3a85-4063-b380-419652de3733' { 'Windows Server 2008 Standard without Hyper-V OEM:SLP' }
        '8210c9d1-4686-4f46-ac2e-56cf4e6ba674' { 'Windows Web Server 2008 OEM:NONSLP' }
        'bab219ac-3f91-4cdc-8339-b643cbdd6c49' { 'Windows Web Server 2008 OEM:SLP' }
        '005cf8e0-d40e-458f-8982-9ea5a37c080c' { 'Server 2008 R2 Server for Windows Essential Server Solutions (WinWES) OEM:NONSLP' }
        'ba480d59-94fc-46de-81f7-baf821e43488' { 'Server 2008 R2 Server for Windows Essential Server Solutions (WinWES) OEM:SLP' }
        '4539dd83-aa84-4cb8-aa73-bc89daf53a3a' { 'Server 2008 R2 Server for Windows Essential Server Solutions (WinWES) Retail' }
        'b0830b97-08a6-4370-b4da-2d136616827e' { 'Server 2008 R2 Server for Windows Essential Server Solutions (WinWES) Volume:MAK' }
        'bc7ebf48-a543-4b10-a267-029e059b5c70' { 'Win 7 Server SB Retail' }
        '79303950-2706-45d7-8157-2f00cdf0d1a4' { 'Windows Server for Small Business OEM:NONSLP' }
        '9f6afe16-133b-4ee3-9278-3d5d32dd2579' { 'Windows Server for Small Business OEM:SLP' }
        '9e52b173-d1b8-4cc7-8a68-fd2ab63e25e0' { 'Windows Server for Small Business Retail' }
        'b7b1d450-fb87-4054-84ee-5db525088124' { 'ServerWinSBV Retail' }
        '104434dc-1ca5-43dd-a2c1-aa662b5dc912' { 'Windows Server for Small Business OEM:NONSLP' }
        '7f8cb0c8-047f-4544-a308-0e3561354ea8' { 'Windows Server for Small Business OEM:SLP' }
        '7b5306ad-0d02-463c-8177-59087ff8a58b' { 'Windows Server for Small Business Retail' }
        'f4d1eec6-76d4-4b91-aef7-10b7cf7ef2cb' { 'ProdKey3 Exchange Svr 2010 00150 DLA/Bypass ByPass Volume:GVLK Vol Lic S' }
        '448516f0-1f1d-48a8-95d9-c955b86b2ce1' { 'ProdKey3 Exchange Svr 2010 00150 ProdAct Retail FPP' }
        'f23dba60-517a-4184-bd26-066d9e3c19a9' { 'Windows Vista SP2 Home Basic OEM:COA' }
        'c9ad502b-ef48-41d1-a2a0-38a38e82fed0' { 'Longhorn Compute Cluster Retail' }
        '7afb1156-2c1d-40fc-b260-aab7442b62fe' { 'Windows Server 2008 ComputerCluster' }
        '88a30fce-0fde-49b0-8cc6-4fbd568e7b5d' { 'Windows Server HPC Retail' }
        '4e491fef-6f37-42a3-ab48-4314d83e3627' { 'Windows Server HPC Retail virtual' }
        'c90d1b4e-8aa8-439e-8b9e-b6d6b6a6d975' { 'Windows Server 2008 Datacenter & Itanium CSVLK' }
        '56df4151-1f9f-41bf-acaa-2941c071872b' { 'Windows Server 2008 Standard & Enterprise CSVLK' }
        'c448fa06-49d1-44ec-82bb-0085545c3b51' { 'Windows Web & Compute Cluster Server 2008 CSVLK' }
        '41606216-0fad-4425-8d6e-63be6ed8dc49' { 'Windows Web & Compute Cluster Server 2008 MAK' }
        '5e9f548a-c8a9-44e6-a6c2-3f8d0a7a99dd' { 'Longhorn Compute Cluster V Retail' }
        '68b6e220-cf09-466b-92d3-45cd964b9509' { 'Windows Server 2008 Datacenter' }
        '866e924e-c2a3-4872-aca1-6b48c13962d5' { 'Windows Server 2008 Datacenter Retail' }
        'e9add589-f877-4aad-af6b-d641674d4ac9' { 'Windows Server 2008 Datacenter & Itanium MAK' }
        'fd09ef77-5647-4eff-809c-af2b64659a45' { 'Windows Server 2008 DatacenterV' }
        'c1af4d90-d1bc-44ca-85d4-003ba33db3b9' { 'Windows Server 2008 Enterprise' }
        '32b40e5e-0c6d-4c6f-ab12-a031933fd2c6' { 'Windows Server 2008 Enterprise Retail' }
        'bb1d27c4-959d-4f82-b0fd-c02a7be54732' { 'Windows Server 2008 Standard & Enterprise MAK' }
        '01ef176b-3e0d-422a-b4f8-4ea880035e8f' { 'Windows Server 2008 Itanium GVLK' }
        '1ba5e036-e386-42c4-b7eb-16bdb4fa1945' { 'Windows Server 2008 Enterprise without Hyper-V Retail' }
        '8198490a-add0-47b2-b3ba-316b12d647b4' { 'Windows Server 2008 EnterpriseV' }
        '8df04457-07c8-4301-bce9-d61eb76cb2d6' { 'Windows Home Server Premium Retail' }
        '5bd23b19-aa71-4a5b-8b68-c8801c2baff6' { 'Windows Home Server Standard Retail' }
        '2cf1c8d6-ebe1-4ce9-83c6-c4877fae1355' { 'Hyper-V ProdAct All Programs' }
        'b86c7736-91ff-4de9-bfa9-b32b8a09acac' { 'Longhorn Medium Business Server Management Retail' }
        'd3f5642f-081d-40b2-a4b9-efd3054d4584' { 'Longhorn Medium Business Server Messaging Retail' }
        'c6936a36-69f3-4994-9857-3069c7b9ec7a' { 'Longhorn Medium Business Server Security Retail' }
        'cc4c2cf8-ef29-4d8e-b168-2b65a3db3309' { 'Longhorn SBS Premium Retail' }
        'b3827b27-bd38-4284-98af-e4f4d1c051a0' { 'Longhorn SBS Prime Retail' }
        '5dad0eff-3f6f-4310-8844-422f9dc7c84b' { 'Longhorn SBS Standard Retail' }
        '0957c488-4993-4b07-a2a4-0097b2f8c37d' { 'Windows Small Business Server 2011 Standard ServerSBSStandard OEM:NONSLP' }
        '2b756fa4-e8d3-4eac-8722-07b044e7b6b1' { 'Windows Small Business Server 2011 Standard ServerSBSStandard OEM:SLP' }
        'a685cfa9-39ff-4d7d-a7ff-26e492314852' { 'Windows Small Business Server 2011 Standard ServerSBSStandard Retail' }
        'b5f35387-daeb-4901-a253-c6001f14fda7' { 'Windows Small Business Server 2011 Standard ServerSBSStandard Retail:TB:Eval' }
        '9bc8998c-0d54-4d44-b299-fb778ec57230' { 'Windows Small Business Server 2011 Essentials ServerSolution OEM:NONSLP' }
        '0dbe8d16-b9e1-435f-9fc8-5e011438eb4c' { 'Windows Small Business Server 2011 Essentials ServerSolution OEM:SLP' }
        '29b15bf5-8d7f-47e2-a0a7-ce1061254a0f' { 'Windows Small Business Server 2011 Essentials ServerSolution Retail' }
        'e1808e9b-b84c-4b3e-a351-d9820702720c' { 'Windows Small Business Server 2011 ServerSolution, ServerSBSStandard Volume:MAK' }
        'ad2542d4-9154-4c6d-8a44-30f11ee96989' { 'Windows Server 2008 Standard' }
        '603504f9-109f-49f0-9271-8c66f7878f58' { 'Windows Server 2008 Standard Retail' }
        '65ab7338-9ad0-43fe-af1b-190b577495e2' { 'Windows Server 2008 Standard without Hyper-V Retail' }
        '2401e3d0-c50a-4b58-87b2-7e794b7d2607' { 'Windows Server 2008 StandardV' }
        '2be204da-24a0-4943-b66c-81e8464acd7e' { 'Windows Storage Server Enterprise  Retail' }
        '60207eba-8b4a-486c-a013-023b4b742c2f' { 'Windows Storage Server Express Retail' }
        '368856e9-43f7-4601-8358-e561f36c7dd8' { 'Windows Storage Server  Standard Retail' }
        '4bf433fa-ab04-4c6c-b55b-00170e14b8cd' { 'Windows Storage Server Workgroup Retail' }
        'ddfa9f7c-f09e-40b9-8c1a-be877a9a7f4b' { 'Windows Server 2008 Web' }
        'a77a6806-f59e-4953-97d7-229317b8e6a6' { 'Windows Web Server 2008 Retail' }
        'f92f836d-4d3e-4e90-a08f-2d612d65e716' { 'Longhorn Server for Small Business Retail' }
        '3059a9fd-b068-4f0d-acaf-66324dca67ac' { 'Longhorn Server for Small Business V Retail' }
        '0101b69a-85c8-4344-8196-7a16a7790bb5' { 'Windows Vista Business - OEM:COA' }
        'e12dd57d-07d5-4f64-9139-a92489a626b0' { 'Windows Vista Business OEM:SLP' }
        'faba8d9b-3ad6-4529-b11d-d41ec9b5d47b' { 'Windows Vista Business Retail' }
        '4871de8b-3adf-4455-a7d3-fd7b6c01c939' { 'Windows Vista ALL Volume SKUs - CSVLK' }
        '132ccb0c-51e9-49c4-b157-ccf977259947' { 'Windows Vista Business N Retail' }
        'c2f2d79e-121d-482c-b665-83f052c8cbcc' { 'Windows Vista Home Basic - OEM:COA' }
        'a3481201-436e-4fc9-88b4-34ccf7f81789' { 'Windows Vista Home Premium - OEM:COA' }
        '3a1d44e2-bede-46fb-8a02-0cd485a1db8b' { 'Windows Vista Home Premium Retail' }
        '55e6dada-345d-41ab-83f0-99ad84ac1d19' { 'Windows Vista Home Premium N OEM:COA' }
        '413036e1-7bcf-4a02-bab4-7b6916f17f87' { 'Windows Vista Home PremiumN OEM:SLP' }
        '24d57dfd-f6e1-48f9-a045-0520a52f84c7' { 'Windows Vista Starter OEM:COA' }
        '12d7799d-9db2-4378-abb8-efaca84a6133' { 'Windows Vista Starter OEM:SLP' }
        '1105ac4c-f808-42d2-a6ae-f46183169f6f' { 'Windows Vista Starter Retail' }
        'a797d61e-1475-470b-86c8-f737a72c188d' { 'Windows Vista StarterN Retail' }
        'f00fa8e9-ac0f-4f43-a259-a26c110cbbf9' { 'Windows Vista Ultimate - OEM:COA' }
        '56a13760-2b9c-406f-be8a-8f2ef22f10b5' { 'Windows Vista Ultimate MAK' }
        '1f59edc8-ad79-4d96-a62d-c33ee78da2ec' { 'Windows Vista Ultimate Retail' }
        '2bd10086-9094-4140-801e-3d8ec5b0ac25' { 'Windows Vista Ultimate N - OEM:COA' }
        '7fbe00d4-bff2-47a3-99a7-6387fd509ae2' { 'Windows Vista UltimateN - OEM:SLP' }
        '8f1c2cd6-4d70-4122-8eee-b4de3fb9ba17' { 'Windows Vista UltimateN MAK' }
        '90f4e13a-12fb-4840-b9ab-91cfb9fac5e2' { 'Windows Vista UltimateN Retail' }
        '093e8e65-b6ab-4526-ab64-ae4e8269b656' { 'Windows Vista Business - OEM:NONSLP' }
        '829a4bc1-2a89-47ba-a638-0b8a206b0986' { 'Windows Vista Business Retail' }
        '8cc39469-8bf4-4859-9f14-639320501a1f' { 'Windows Vista Home Basic - OEM:NONSLP' }
        'c5d8ec70-e2ae-42d8-aaa9-eec3772438ee' { 'Windows Vista Home Premium - OEM:NONSLP' }
        '776ec0e8-2a6f-4e55-94f2-b6b1fa9cf4c5' { 'Windows Vista Home Premium N - OEM:NONSLP' }
        'a2855032-266b-45e6-8739-311652feeb28' { 'Windows Small Business Server 2011 Standard ServerSBSStandard OEM:NONSLP' }
        '3180af80-a6fe-4521-99cd-98808707f510' { 'Windows Small Business Server 2011 Standard ServerSBSStandard Retail' }
        '28e73646-24dc-4222-bf00-de8ded35ce13' { 'Windows Small Business Server 2011 Essentials ServerSolution OEM:NONSLP' }
        '5722cd65-5a5c-4315-957a-0e4e5daef5cd' { 'Windows Vista Starter - OEM:NONSLP' }
        'a79a48fc-70d9-4413-ab47-81cf5d08f7ee' { 'Windows Vista Ultimate - OEM:NONSLP' }
        'fbe5f9be-2204-480a-93da-a5f81b3c52d9' { 'Windows Vista Ultimate N - OEM:NONSLP' }
        'cd2e414a-e728-421e-a934-73506387d641' { 'Windows Vista Home Basic - OEM:COA' }
        'da0483a8-c443-45fd-9b52-2bba9b2ee8ab' { 'Windows Vista SP2 Home Premium OEM:COA' }
        '08efb8fe-c403-4019-a084-9da91108cead' { 'Windows Vista SP2 Home PremiumN OEM:NONSLP' }
        'd6a70f3f-2052-4633-a9aa-25ea0cdff672' { 'Windows Vista Ultimate - OEM:COA' }
        'b4b150d0-ec09-4f74-910d-371ed161b2ac' { 'Windows Vista Home Basic - OEM:COA' }
        'b13b0123-8661-4ee2-afb7-05c37481686b' { 'Windows Vista Business - OEM:COA' }
        '7e0e0685-8eef-47b8-8b25-f03f9819eb17' { 'Windows Vista SP2 Business OEM:NONSLP' }
        '121059c3-724a-48ba-b745-5ab6daad8e37' { 'Windows Vista SP2 Home Basic OEM:NONSLP' }
        'e05164a4-fb9a-471f-8c3a-6959b4cf1b72' { 'Windows Vista SP2 Home Premium OEM:COA' }
        'a7a4a974-ad47-420e-8e1a-83d28572058a' { 'Windows Vista SP2 Home Premium OEM:NONSLP' }
        '6c47797a-fdba-4ac8-b402-d4b937bb7edb' { 'Windows Home Server 2011 SERVERHOMEPREMIUM OEM:NONSLP' }
        '3ff36ff8-6220-484c-9fb0-165ac44e0a91' { 'Windows Home Server 2011 SERVERHOMEPREMIUM OEM:SLP' }
        '16cc978a-cf08-44f4-b02b-dfeb8bdacac2' { 'Windows Home Server 2011 SERVERHOMEPREMIUM Retail' }
        'd26969d7-e588-4ec8-9e52-911cbe0f744a' { 'Windows Home Server 2011 SERVERHOMEPREMIUM Retail:TB:Eval' }
        'b7c0e03c-9b98-4219-82dd-d17d9543891c' { 'Windows Medium Business Server Management  Retail' }
        '1404ea26-d078-4786-886a-0da035b2cd5a' { 'Windows Medium Business Server Management OEM:NONSLP' }
        '7c4ab58c-78f4-4403-bda2-d5bfb449ddf1' { 'Windows Medium Business Server Management OEM:SLP' }
        '92da208a-1a89-4407-88e6-bb5ca02aec47' { 'Windows Medium Business Server Messaging  Retail' }
        'c99b1d91-25f1-4024-a20c-0e9da8d15225' { 'Windows Medium Business Server Messaging OEM:NONSLP' }
        'feb01ead-d438-4556-a5b3-2b6557da8737' { 'Windows Medium Business Server Messaging OEM:SLP' }
        '9c07c927-9017-4dbf-84e7-06c3a61fed6a' { 'Windows Medium Business Server Security  Retail' }
        '74143dee-b000-419d-badc-b650f7e316e4' { 'Windows Medium Business Server Security OEM:NONSLP' }
        'c135db9b-0074-4ef9-a405-a415de4e31a5' { 'Windows Medium Business Server Security OEM:SLP' }
        '0dddb5b3-94b1-4b69-a916-6c82ea5542c5' { 'Windows Storage Server Enterprise - MSDN' }
        '43329da1-7874-4e67-b612-3d59697b1677' { 'Windows Storage Server Enterprise - OEM COA' }
        '416733c6-d43f-4ba1-b6e0-722aa4573cdf' { 'Windows Storage Server Enterprise - OEM NSLP' }
        'fdd923f8-4409-4a72-becd-d7e9aa59bca3' { 'Windows Storage Server Enterprise - OEM SLP' }
        '374a5900-7184-43cd-a96f-abfcc30a1b27' { 'Windows Storage Server Express - MSDN' }
        '8e87fd23-319d-4cd6-8aa2-c590b7b0a42c' { 'Windows Storage Server Express - OEM COA' }
        'f6a8f9fe-e072-4cb4-9fe2-a8276a1f161a' { 'Windows Storage Server Express - OEM NSLP' }
        'b2b347e5-e754-468d-afc1-7b2187288814' { 'Windows Storage Server Express - OEM SLP' }
        '7139ded4-7373-4651-b44b-9de7ea72ccd4' { 'Windows Storage Server Standard - MSDN' }
        '3c73fddf-ec70-43b2-b642-abd2d575e102' { 'Windows Storage Server Standard - OEM COA' }
        '5f4eb8c3-37e4-4a56-97c9-60ad9a03763d' { 'Windows Storage Server Standard - OEM NSLP' }
        'f6c23d59-6d32-4b41-acad-b0fa170733cb' { 'Windows Storage Server Standard - OEM SLP' }
        'ce0df6b6-ff0f-463c-93ed-3cd71752a8ac' { 'Windows Storage Server Workgroup - MSDN' }
        '527803e5-f705-433b-a7f1-10b647e5369a' { 'Windows Storage Server Workgroup - OEM COA' }
        'abb3e789-58ae-42ae-b308-bb2c831db127' { 'Windows Storage Server Workgroup - OEM NSLP' }
        'a499fe43-12de-4873-8971-1cff6173cdaa' { 'Windows Storage Server Workgroup - OEM SLP' }
        '4cb70ae9-faf0-4cc1-88e5-f9d1d388e39a' { 'Windows Vista SP2 Starter OEM:NONSLP' }
        '95fac25a-4268-48c3-ae04-071ea19594fa' { 'Windows Vista SP2 Ultimate OEM:NONSLP' }
        '6f4429fd-9729-443a-abfc-a3daf21ba4b6' { 'Windows Vista SP2 Home Basic OEM:COA' }
        '657fd7f1-652f-4a7f-9cef-e45e60f8b4c7' { 'Windows Vista SP2 Home Basic OEM:NONSLP' }
        '6b16d38b-7dac-4614-9948-b4a92ddba889' { 'Windows Vista SP2 Home Premium OEM:COA' }
        '11db994f-af86-4eb9-af35-fb4e3b0256f5' { 'Windows Vista SP2 Home Premium OEM:NONSLP' }
        'ab8e6bc4-0499-484e-8da1-761697126843' { 'Windows Vista SP2 Home PremiumN OEM:COA' }
        'c6166b46-aba5-4374-8bdf-be06bde66223' { 'Windows Vista SP2 Home PremiumN OEM:NONSLP' }
        '920b06bf-f7d3-4291-80d3-5d3d91a8be4c' { 'Windows Vista SP2 Starter OEM:COA' }
        '7fd7e3ea-1a64-4e14-abc6-541992c5ef64' { 'Windows Vista SP2 Ultimate OEM:COA' }
        'e9528038-4625-4693-ac4d-43387ec18233' { 'Windows Vista SP2 UltimateN OEM:COA' }
        '70449d13-fe2e-453e-a19f-68b031ff1a19' { 'Windows Vista SP2 UltimateN OEM:NONSLP' }
        '1d63ae00-7733-4e46-b0d0-ae0ab81d7638' { 'Server 2008 R2 Datacenter OEM:NONSLP' }
        'b41df512-845d-4384-a2d7-ace3f778bff5' { 'Server 2008 R2 Datacenter OEM:SLP' }
        'e1f0bb5b-2421-4b7c-81a1-03643106421d' { 'Server 2008 R2 Datacenter retail' }
        'c0c97b05-e71a-4fe4-b234-4165f96250f6' { 'Server 2008 R2 Datacenter Retail:TB:Eval' }
        '7482e61b-c589-4b7f-8ecc-46d455ac3b87' { 'Windows Server 2008 R2 Datacenter' }
        '4ae528f4-05c3-446e-90ea-a4fbd460b83a' { 'Server 2008 R2 DC and IA64 Volume:MAK (MAK_C)' }
        '8fe15d04-fc66-40e6-bf34-942481e06fd8' { 'Server 2008 R2 DC and IA64 Volume:CSVLK (KMS_C)' }
        '862e432e-a461-42cf-b5dd-abc373943a4a' { 'Multipoint Server OEM:NONSLP' }
        'db1b36e0-f543-4f4d-8ce6-814fa5dea00d' { 'Multipoint Server OEM:SLP' }
        '511bf083-7a59-4f5c-b41e-81c97e039fe9' { 'Multipoint Server Retail' }
        'f772515c-0e87-48d5-a676-e6962c3e1195' { 'Multipoint Server Volume:GVLK' }
        'c74dc7f6-ea35-4bd7-9776-333ab5dddae6' { 'Server 2008 R2 Enterprise OEM:NONSLP' }
        'ea36520d-fbfe-4042-acd8-fe926781b615' { 'Server 2008 R2 Enterprise OEM:SLP' }
        'b297426d-464d-4af1-abb2-3474aeecb878' { 'Server 2008 R2 Enterprise retail' }
        '4bcc8879-e699-4159-a810-f829566662ca' { 'Server 2008 R2 Enterprise Retail:TB:Eval' }
        '620e2b3d-09e7-42fd-802a-17a13652fe7a' { 'Windows Server 2008 R2 Enterprise' }
        'c74417bd-f079-42e5-91f0-8f08ec052cba' { 'Server 2008 R2 Enterprise IA64 OEM:NONSLP' }
        'eea69412-4907-4185-8322-2ce1be6912a3' { 'Server 2008 R2 Enterprise IA64 OEM:SLP' }
        '30e54fa6-ae6a-4523-b264-d7978e977d96' { 'Server 2008 R2 Enterprise IA64 retail' }
        '63192b0b-20c9-49dc-9936-0a33d67f8c3a' { 'Server 2008 R2 Enterprise IA64 Retail:TB:Eval' }
        '8a26851c-1c7e-48d3-a687-fbca9b9ac16b' { 'Server 2008 R2 Enterprise IA64 Volume:GVLK' }
        '683b8d26-5471-4212-82fb-8148427ca281' { 'Server 2008 R2 Compute Cluster (HPC) OEM:COA' }
        '23af83d3-8520-491e-88fb-3f6d7ab3783a' { 'Server 2008 R2 Compute Cluster (HPC) OEM:NONSLP' }
        'b4d69df9-cdc5-48aa-8b88-dcadf9b558ba' { 'Server 2008 R2 Compute Cluster (HPC) OEM:SLP' }
        '855d35f4-a334-46e7-b7d7-23fc1a22be65' { 'Server 2008 R2 Compute Cluster (HPC) retail' }
        'cda18cf3-c196-46ad-b289-60c072869994' { 'Windows Server 2008 R2 ComputerCluster' }
        '171ad3f3-e1f3-41e1-9d6f-0a0b9b6aba3f' { 'Windows Small Business Server 2011 Essentials ServerSolution Retail' }
        '6d47464d-e43d-4228-b051-fddd47fd403f' { 'Server 2008 R2 Standard OEM:NONSLP' }
        '9a159de8-d114-41d7-a5bf-d3574edb42fa' { 'Server 2008 R2 Standard OEM:NONSLP (GEO locked to CH)' }
        'a60c85a9-7eff-4690-8aa1-010ddf5d38f0' { 'Server 2008 R2 Standard OEM:SLP' }
        '039998e3-3ef5-4adf-b758-d25fa0128ff4' { 'Server 2008 R2 Standard Retail' }
        'f14c8ee3-560d-441e-aee1-325c2e9ae74a' { 'Server 2008 R2 Standard Retail (GEO locked to CH)' }
        'da71774d-b2c9-4c42-bb7b-a66365d5abb2' { 'Server 2008 R2 Standard Retail:TB:Eval' }
        '68531fb9-5511-4989-97be-d11a0f55633f' { 'Windows Server 2008 R2 Standard' }
        'c837408d-3762-4dea-a4d7-6dba48f6c305' { 'Server 2008 RC Standard OEM:SLP' }
        '6a4bd364-4b60-4856-a727-efb59d94348e' { 'Server 2008 R2 Std and Ent Volume:MAK (MAK_B)' }
        'c99b641f-c4ea-4e63-bec3-5ed2ccd0f357' { 'Server 2008 R2 Std and Ent Volume:CSVLK (KMS_B)' }
        '280f12e2-5412-4482-9004-b4c90a66e829' { 'Server 2008 R2 Web OEM:NONSLP' }
        '4d3ae49a-0bea-4cea-9a9f-a6fbdf699b28' { 'Server 2008 R2 Web OEM:SLP' }
        '1393c801-f389-4c5b-bb4e-bd7d3478ea60' { 'Server 2008 R2 Web retail' }
        '1bc49a17-9894-49c8-ba63-1b52852556a3' { 'Server 2008 R2 Web Retail:TB:Eval' }
        'a78b8bd9-8017-4df5-b86a-09f756affa7c' { 'Windows Server 2008 R2 Web' }
        'f73d1bcd-0802-47dd-b2d9-81bf2f8c0744' { 'Server 2008 R2 Web and CC Volume:CSVLK (KMS_A)' }
        '506fb694-7202-4d00-9069-f696ebf921f2' { 'Server 2008 R2 Web and CC Volume:MAK (MAK_A)' }
        'fe0e7d01-192a-47c1-858e-95df10baa491' { 'Server 2008 R2 Foundation OEM:NONSLP' }
        'e3913f37-c311-4a0d-b603-ad3d61be9e39' { 'Server 2008 R2 Foundation OEM:NONSLP (GEO locked to CH)' }
        '0e0d125d-173f-4752-8c1b-ced62118977f' { 'Server 2008 R2 Foundation OEM:SLP' }
        '2b1690e6-1066-4b17-883f-4f759db1a7dd' { 'Server 2008 R2 Foundation OEM:SLP' }
        '402ffdaa-6813-424a-b07b-c31f8d24054e' { 'Server 2008 R2 Foundation Retail' }
        '0cbae191-195f-43b4-b53c-368b61652b74' { 'Server 2008 R2 Foundation Retail (GEO locked to CH)' }
        'b793ff2d-9d80-407c-b521-85111c51028c' { 'Windows 7 Enterprise Retail' }
        '8dffd6e4-0497-4c35-b7d7-e47cf464cf30' { 'Windows 7 Enterprise Retail:TB:Eval' }
        'ae2ee509-1b34-41c0-acb7-6d4650168915' { 'Windows 7 Enterprise' }
        '6eb02c88-98e6-4623-8edd-59fed8fb5b11' { 'Windows 7 EnterpriseE Retail' }
        'e16f11e3-ba84-48cb-af72-a7a0deafe0e8' { 'Windows 7 EnterpriseE Retail:TB:Eval' }
        '46bbed08-9c7b-48fc-a614-95250573f4ea' { 'Windows 7 EnterpriseE Volume:GVLK' }
        '33eda5ad-ad65-4507-b585-abcac3cabae5' { 'Windows 7 EnterpriseN Retail' }
        'f3ce0211-9843-4d7e-9e38-a55ae0cd3c33' { 'Windows 7 EnterpriseN Retail:TB:Eval' }
        '1cb6d605-11b3-4e14-bb30-da91c8e3983a' { 'Windows 7 EnterpriseN' }
        'b1184982-a958-4643-8e66-445fa0f92832' { 'Windows 7 Home Basic Retail' }
        '7f62a589-fc1c-4fc7-817b-90d565727ddb' { 'Windows 7 HomeBasicE Retail' }
        'd1b53b3d-38eb-46a7-9afa-47271d93aec4' { 'Windows 7 Home BasicN Retail' }
        '2e7d060d-4714-40f2-9896-1e4f15b612ad' { 'Windows 7 Home Premium Retail' }
        '8d1786df-c824-49e4-8353-0525ee16c980' { 'Windows 7 HomePremiumE Retail' }
        '8d2813f4-654e-4aad-9786-dba84bfe33d6' { 'Windows 7 Home PremiumN Retail' }
        '4a8149bb-7d61-49f4-8822-82c7bf88d64b' { 'Windows 7 OCUR Retail' }
        'e838d943-63ed-4a0b-9fb1-47152908acc9' { 'Windows 7 Professional Retail' }
        'b92e9980-b9d5-4821-9c94-140f632f6312' { 'Windows 7 Professional' }
        '36c9cf6d-4b2b-4311-8552-e36d8c601781' { 'Windows 7 ProfessionalE Retail' }
        '5a041529-fef8-4d07-b06f-b59b573b32d2' { 'Windows 7 ProfessionalE Volume:GVLK' }
        '0bdb55f8-df23-41e9-bd76-a3b9cc40d7ca' { 'Windows 7 ProfessionalN Retail' }
        '54a09a0d-d57b-4c10-8b69-a842d6590ad5' { 'Windows 7 ProfessionalN' }
        '71c7c851-1863-4232-8ac2-cdd7f5e45dae' { 'Windows 7 Starter Retail' }
        '07a012bd-c5b1-483a-a3ac-20da32d44dec' { 'Windows 7 StarterE Retail' }
        '51ba3bd9-c1cd-42b5-ada3-22451bc151f4' { 'Windows 7 StarterN Retail' }
        'ac96e1a8-6cc4-4310-a4ff-332ce77fb5b8' { 'Windows 7 Ultimate Retail' }
        '520130ee-efd4-4de0-99e0-565a86d7aeff' { 'Windows 7 UltimateE Retail' }
        'fa3d0658-67f4-4a26-ba57-3fc6f39861f1' { 'Windows 7 UltimateN Retail' }
        'd188820a-cb63-4bad-a9a2-40b843ee23b7' { 'Windows 7 All Volume Editions Volume:CSVLK' }
        '6c7afc31-950c-4fa8-93ee-3e880aa97e5d' { 'Windows 7 Home Basic Retail' }
        '88e1193d-e891-41c4-b517-3a305a013695' { 'Windows 7 HomeBasicE Retail' }
        'ca400347-52d3-45a2-a333-f7d4c33b6af5' { 'Windows 7 Home BasicN Retail' }
        '9ab82e0c-ffc9-4107-baa1-c65a8bd3ccc3' { 'Windows 7 Home Premium OEM:NONSLP' }
        '3b965dfc-31d9-4903-886f-873a0382776c' { 'Windows 7 Home Premium Retail' }
        '26cd687a-c069-49bd-adba-c622441a2d81' { 'Windows 7 Home PremiumE OEM:NONSLP' }
        '903e621f-f23c-4ba0-b8de-40c3affff57d' { 'Windows 7 HomePremiumE Retail' }
        '2143d01a-961c-4d9e-9150-6b5de0011274' { 'Windows 7 Home PremiumN OEM:NONSLP' }
        'b68cc682-9531-4b6c-bb5e-202c92a59946' { 'Windows 7 Home PremiumN Retail' }
        '770bc271-8dc1-467d-b574-73cbacbeccd1' { 'Windows 7 Professional Retail' }
        '9abf5984-9c16-46f2-ad1e-7fe15931a8dd' { 'Windows 7 All Volume Editions Volume:MAK' }
        '78c95341-4f01-4e52-808a-e2f90fc56f71' { 'Windows 7 ProfessionalE Retail' }
        'c63f22b5-fdaf-4488-aeac-cc19411d0243' { 'Windows 7 ProfessionalN Retail' }
        '197247fa-8fb7-4a9d-9415-1ba0e14215e8' { 'Windows 7 Starter OEM:NONSLP' }
        '42d70d37-136a-4eba-9d21-b394a73b7516' { 'Windows 7 StarterE OEM:NONSLP' }
        'dd14134a-d56c-4bc0-a2e9-14c462b4295b' { 'Windows 7 StarterN OEM:NONSLP' }
        'a0cde89c-3304-4157-b61c-c8ad785d1fad' { 'Windows 7 Ultimate Retail' }
        '18aa7613-98ff-4820-9b69-1f69105ebba8' { 'Windows 7 UltimateE Retail' }
        'dca01e19-01f5-4ce1-98b1-35fb7a323806' { 'Windows 7 UltimateN Retail' }
        '586bc076-c93d-429a-afe5-a69fbc644e88' { 'Windows 7 Home Premium OEM:NONSLP' }
        'bbbb2a8a-aaee-4f56-a237-1e2cdc8039d6' { 'Windows 7 HomePremiumE OEM:NONSLP' }
        '9f83d90f-a151-4665-ae69-30b3f63ec659' { 'Windows 7 Home Premium OEM:NONSLP' }
        'f7bc3d0d-ca9d-42ae-83e1-4fa46e0f4979' { 'Windows 7 HomePremiumE OEM:NONSLP' }
        '358fb95b-0090-44fb-883a-75734e060c30' { 'Windows 7 Enterprise OEM:SLP' }
        '07328a5d-8dee-4d3b-9974-8a6ad6ab6892' { 'Windows 7 EnterpriseN OEM:SLP' }
        '774d5df6-d8dd-4d92-98bc-58825849d249' { 'Windows 7 Home Basic OEM:NONSLP' }
        'bde0d4a5-2f2a-4bff-9d75-4a497d2d0019' { 'Windows 7 Home Basic OEM:SLP' }
        'f1fe0f5e-7a50-4853-984d-9abd2dc05b6e' { 'Windows 7 HomeBasicE OEM:NONSLP' }
        '5757ccd7-4e7d-4723-a9a1-c5315263460d' { 'Windows 7 HomeBasicE OEM:SLP' }
        '0fa327c5-2ba7-4090-ade8-0ec3eeda3242' { 'Windows 7 Home BasicN OEM:NONSLP' }
        '89cc87b2-d442-4c79-99b2-addc5abcf2a5' { 'Windows 7 Home BasicN OEM:SLP' }
        'd2c04e90-c3dd-4260-b0f3-f845f5d27d64' { 'Windows 7 Home Premium OEM:SLP' }
        '5fa5bf1b-c208-491c-846f-4faa3c98767a' { 'Windows 7 HomePremiumE OEM:SLP' }
        '05d94d71-4ba4-427c-98f2-0e058edfe9af' { 'Windows 7 Home PremiumN OEM:SLP' }
        '90a61a0d-0b76-4bf1-a8b8-89061855a4c9' { 'Windows 7 Professional OEM:NONSLP' }
        '50e329f7-a5fa-46b2-85fd-f224e5da7764' { 'Windows 7 Professional OEM:SLP' }
        '0af59e82-53c5-4564-87cd-ddad65d5509f' { 'Windows 7 ProfessionalE OEM:NONSLP' }
        '61944438-77f3-46d0-b434-0f340e01434c' { 'Windows 7 ProfessionalE OEM:SLP' }
        'fc3d428b-656b-4129-8274-700966289991' { 'Windows 7 ProfessionalN OEM:NONSLP' }
        'd932ba14-a8cd-4368-aa5a-90d6613afea7' { 'Windows 7 ProfessionalN OEM:SLP' }
        '8be4a481-9b5c-4588-a5ec-5dad4b1f15da' { 'Windows 7 Starter OEM:SLP' }
        '24371aee-296d-4398-940d-7612d0def8e2' { 'Windows 7 StarterE OEM:SLP' }
        '56f31729-c7c2-46b1-88a9-b2ebde10a7b1' { 'Windows 7 StarterN OEM:SLP' }
        '7cfd4696-69a9-4af7-af36-ff3d12b6b6c8' { 'Windows 7 Ultimate OEM:SLP' }
        'bd61de01-6b6a-4756-8103-2978e8c5c980' { 'Windows 7 UltimateE OEM:SLP' }
        'b482b078-ed27-4750-9ce9-60da4f575c67' { 'Windows 7 UltimateN OEM:SLP' }
        'e120e868-3df2-464a-95a0-b52fa5ada4bf' { 'Windows 7 Professional OEM:NONSLP' }
        'ab761468-3ae8-4696-b762-e77f674ac0c1' { 'Windows 7 ProfessionalE OEM:NONSLP' }
        'd8e04254-f9a5-4729-ae86-886de6aa907c' { 'Windows 7 Professional OEM:NONSLP' }
        '0a6eaa31-2181-4266-b7b3-6b6a0dd0af8a' { 'Windows 7 ProfessionalE OEM:NONSLP' }
        'cfb3e52c-d707-4861-af51-11b27ee6169c' { 'Windows 7 Ultimate OEM:NONSLP' }
        '48fae3c8-9656-4147-bc80-5dd08c50d9bc' { 'Windows 7 UltimateE OEM:NONSLP' }
        '419c2448-cd87-48cd-94d4-7b9af5efd169' { 'Windows 7 UltimateN OEM:NONSLP' }
        'c1027486-8ae8-4633-9cf9-9658ed80504d' { 'Windows 7 Professional OEM:COA' }
        'b2153262-12db-49d1-969a-9ca6b54cf93c' { 'Windows 7 ProfessionalE OEM:COA' }
        '61dbe86e-9979-45b4-8607-ae8b56aead36' { 'Windows 7 ProfessionalN OEM:COA' }
        'd56863eb-6e59-4f2d-ae01-46322b5fba79' { 'Windows 7 Starter OEM:COA' }
        '82866d0f-354b-4dfc-bc75-8b925ba514db' { 'Windows 7 StarterE OEM:COA' }
        'da22eadd-46dc-4056-a287-f5041c852470' { 'Windows 7 Professional OEM:COA' }
        '5f56dc78-0853-4465-81ec-88891d9624b0' { 'Windows 7 ProfessionalE OEM:COA' }
        '276d6155-27e2-437a-95f9-f1251168c970' { 'Windows 7 Starter OEM:COA' }
        '7438e626-0d47-4b81-83db-eeff76921fd7' { 'Windows 7 StarterE OEM:COA' }
        '1c48e75a-71d5-4871-b6f2-bc407894445b' { 'Windows 7 StarterN OEM:COA' }
        '022a1afb-b893-4190-92c3-8f69a49839fb' { 'Windows 7 Ultimate OEM:COA' }
        '2e5cfead-eb89-4b28-87ba-a85917b1b95a' { 'Windows 7 UltimateE OEM:COA' }
        '9b6938df-398f-407d-962f-d99b2e1d5d1b' { 'Windows 7 UltimateN OEM:COA' }
        '9821c9cb-288b-4c98-96f9-adc75a15eaf4' { 'Windows 7 Home Basic OEM:COA' }
        '1d90c7cc-f3cc-4c2f-9650-7ac451fc73eb' { 'Windows 7 Starter OEM:COA' }
        '6841f362-8be0-4058-9c13-8f565ef1debb' { 'Windows 7 StarterE OEM:COA' }
        '25a0d760-2580-4c99-adfb-d57ba93560f5' { 'Windows 7 Home Basic OEM:COA' }
        'f91bf45e-af5f-495a-8cab-5578e1c44da1' { 'Windows 7 HomeBasicE OEM:COA' }
        'd63316d0-1b6c-48e5-8db9-32b4d83fc7a0' { 'Windows 7 Home BasicN OEM:COA' }
        '6a7d5d8a-92af-4e6a-af4b-8fddaec800e5' { 'Windows 7 Home Premium OEM:COA' }
        'd880a111-2ba6-4838-9553-3da0f31d8eb5' { 'Windows 7 HomePremiumE OEM:COA' }
        '01039663-ab8e-4d11-ba6c-cb4dacb2d13e' { 'Windows 7 Home PremiumN OEM:COA' }
        '9dee7406-49c2-43f2-b479-09bc4d5c4399' { 'Windows 7 Starter OEM:COA' }
        '5e017a8a-f3f9-4167-b1bd-ba3e236a4d8f' { 'Windows 7 Home Premium OEM:COA' }
        'cab94894-574c-4ace-8b83-c89d121fda53' { 'Windows 7 HomePremiumE OEM:COA' }
        '01f5fc37-a99e-45c5-b65e-d762f3518ead' { 'Windows 7 Home Premium OEM:COA' }
        '524e0c34-73ce-4198-9878-a53951c6f6b1' { 'Windows 7 HomePremiumE OEM:COA' }
        '489b53ab-7ef4-4bed-a7fb-2099ff4ae75d' { 'Digital License SQLSvr Bsnss Intelligence 2012 DLA #13 Rtl' }
        '2fe1f28d-a399-459e-99e6-427ab1c5628e' { 'Digital License SQLSvr Bsnss Intelligence 2012 DLA #14 VL:GVLK' }
        '9c38cd01-2cb2-497a-bcf1-835d4fcde612' { 'Digital License SQLSvr Bsnss Intelligence 2012 DLA #15 OEM:NONSLP' }
        '4e91c005-6269-462a-968e-1d27ab599041' { 'Digital License SQLSvr Bsnss Intelligence 2014 DLA 14 Retail' }
        'e037b58f-d6fd-4888-9659-e38c65c27540' { 'Digital License SQLSvr Bsnss Intelligence 2014 DLA 15 Retail' }
        'f38639a4-e44e-4435-b0d5-e0845457aeac' { 'Digital License SQLSvr Bsnss Intelligence 2014 DLA 15 VL GVLK' }
        'f9f6f415-6f7c-46e3-93db-bbcd1fc8ad22' { 'Digital License SQLSvr Bsnss Intelligence 2014 DLA 16 OEM NONSLP' }
        '76b74c0c-f17b-4047-b194-ec2aeb4938ce' { 'Digital License SQLSvr Bsnss Intelligence 2014 DLA 17 Retail' }
        'b1787d41-7354-436f-aaa0-e211e822b3a4' { 'Digital License SQL Svr Developer Edtn 2012 DLA #4 Rtl' }
        '96cb4287-a8fc-4b40-9f63-9c5fdeddb334' { 'Digital License SQL Svr Developer Edtn 2012 DLA #5 VL:GVLK' }
        'b52edec0-9fcd-409c-8976-63817cde2e5e' { 'Digital License SQL Svr Developer Edtn 2014 DLA 4 Retail' }
        'f93aeb35-6914-4ecf-a7d1-d2b85ae4c970' { 'Digital License SQL Svr Developer Edtn 2014 DLA 5 VL GVLK' }
        '2b28d3cd-b3f5-45d9-8962-41b4f976b8e0' { 'Digital License SQL Svr Developer Edtn 2014 DLA 6 Retail' }
        'b1a674ad-286d-4dcb-9a15-0bc0079ac564' { 'Digital License SQL Svr Enterprise Edtn 2012 DLA #1 Rtl' }
        'e25f25f5-b67b-40f4-b2fc-23e838512c43' { 'Digital License SQL Svr Enterprise Edtn 2012 DLA #11 Rtl' }
        'c9787455-e322-4ee7-84f9-6584ac3bd9f6' { 'Digital License SQL Svr Enterprise Edtn 2012 DLA #2 VL:GVLK' }
        'fa2c3e3f-9423-4c39-a96b-f8c13cb572dd' { 'Digital License SQL Svr Enterprise Edtn 2012 DLA #3 OEM:NONSLP' }
        'd5f4662f-6678-4263-a30c-af4d1580e85e' { 'Digital License SQL Svr Enterprise Edtn 2014 DLA 1 VL GVLK' }
        '84a14567-d550-4bc1-a851-38a76e24ca33' { 'Digital License SQL Svr Enterprise Edtn 2014 DLA 12 Retail' }
        '99e351f3-781e-4b26-9fe4-46347603dfbf' { 'Digital License SQL Svr Enterprise Edtn 2014 DLA 18 Retail' }
        '1583f29d-c785-409b-b709-6dc8ba9ae316' { 'Digital License SQL Svr Enterprise Edtn 2014 DLA 19 OEM NOSLP' }
        'db73a6bc-8776-49e3-b9f8-aa1ff0d98435' { 'Exchange Server 2013 Enterprise Volume:GVLK' }
        'f4d1eec6-76d4-4b91-aef7-10b7cf7ef2cb' { 'Exchange Server 2013 Enterprise Volume:GVLK' }
        'F149BC3D-D55A-482A-964B-C75A7D67B382' { 'Exchange Server 2013 Enterprise Volume:GVLK' }
        'fa251c2a-0d64-44a9-bfc5-5539a175f306' { 'Digital License SQL Svr Ent Core 2012 DLA 16:VLGVLK' }
        'b91e007c-4161-4370-af83-761a5665cbde' { 'Digital License SQL Svr Ent Core 2012 DLA 17:Rtl' }
        '678098f2-2dd4-4d98-948b-d7f1fd3bf454' { 'Digital License SQL Svr Ent Core 2012 DLA 18:OEMSLP' }
        '591c2e3d-2656-474b-b216-71e82f19d2c5' { 'Digital License SQL Svr Ent Core 2014 DLA 2 VL GVLK' }
        'ccad730c-7da4-4582-82f3-3d50117c2f01' { 'Digital License SQL Svr Ent Core 2014 DLA 21 Retail' }
        '2aada3db-2bf2-46f0-ae65-17e99b924ea5' { 'Digital License SQL Svr Ent Core 2014 DLA 3 OEM NONSLP' }
        'a40c3047-54c3-4bf9-8f09-fb7146cfcb02' { 'WinNext Beta Enterprise;EnterpriseN;Professional;ProfessionalN;Education;EducationN;ProfessionalS;ProfessionalSN;EnterpriseS;EnterpriseSN Volume:CSVLK' }
        'eadc1a4c-f47e-4469-b76d-e9b16c1ee263' { 'Exchange Server 2013 Enterprise_GER Volume:GVLK' }
        '01BEB5F2-A6C5-47B5-A6B5-26942519DA06' { 'Exchange Server 2013 Enterprise_GER Volume:GVLK' }
        'FD0963D6-D848-43E3-BEBA-1BCFB1077700' { 'Exchange Server 2013 Enterprise_GER Volume:GVLK' }
        '810e1800-acc1-496a-a252-ffcaf1ead0fb' { 'Digital License Visual Studio Express 2013 DLA Retail 13' }
        '6c5dba02-bdef-4a00-bd46-94fd8107b093' { 'Digital License Visual Studio Express 2013 DLA Retail 14' }
        '879510c2-a474-4e59-8e93-4ba0925127d6' { 'Digital License Visual Studio Express 2013 DLA Retail 15' }
        'ee5def05-86d9-4c43-8798-65baa2ce2cbb' { 'Digital License Visual Studio Express 2013 DLA Retail 16' }
        'd87932eb-6647-402c-b054-a4bae5c2d274' { 'Digital License Visual Studio Express 2013 DLA Retail 10' }
        '57eebb0a-8da0-4fae-8911-6de28882c9f8' { 'Digital License Visual Studio Express 2013 DLA Retail 11' }
        '566c41d9-672e-4a73-bb48-bf5cf3eb4d57' { 'Digital License Visual Studio Express 2013 DLA Retail 12' }
        'e60f2d53-4a21-4413-b66b-14ae4a9c3a38' { 'Digital License Visual Studio Express 2013 DLA Retail 9' }
        '08371569-74c5-418c-9914-7c662192cfca' { 'VS Dev11 RTM Express for Web Retail' }
        '17533ffb-4f43-4210-a3f2-d9b4dafd44e2' { 'VS Dev11 RTM Express for Web Retail' }
        'a4bb8265-26e3-44bb-a53a-b39e02b8b4b0' { 'VS Dev11 RTM Express for Web Retail' }
        'c41e3fa4-fb4c-4e0a-a0b0-a43360921a36' { 'VS Dev11 RTM Express for Web Retail' }
        '455d4577-4f5e-44bd-9e02-82fcaccfb5aa' { 'Digital License Visual Studio Express 2013 DLA Retail 5' }
        'b4f31246-7ad6-46c4-8cb4-69318d580cb4' { 'Digital License Visual Studio Express 2013 DLA Retail 6' }
        'e357aee0-2e76-4109-9dc1-505a38769acc' { 'Digital License Visual Studio Express 2013 DLA Retail 7' }
        'aa93f842-9be3-421d-b16f-58c00471d88f' { 'Digital License Visual Studio Express 2013 DLA Retail 8' }
        '07547456-b9c7-4c1a-bfb2-2e4f6ea1b910' { 'VS Dev11 RTM Express for Windows Retail' }
        '4e6f6164-b499-4b78-a8f8-cef0718400c3' { 'VS Dev11 RTM Express for Windows Retail' }
        '9964b447-908e-4ce7-b719-411b8d758f74' { 'VS Dev11 RTM Express for Windows Retail' }
        'e4d8d84c-de56-468d-90b5-de3982713f68' { 'VS Dev11 RTM Express for Windows Retail' }
        '21b721bc-3fa1-4cc5-bb97-6afb561d06d4' { 'VS Dev11 RTM Express for Windows Phone Retail' }
        '7cb2a284-c500-465b-aa85-36c6632cccee' { 'VS Dev11 RTM Express for Windows Phone Retail' }
        '82780c12-dc28-4042-84b1-117fbad68228' { 'VS Dev11 RTM Express for Windows Phone Retail' }
        'fa0993be-3e5c-44ef-8732-ce014f281734' { 'VS Dev11 RTM Express for Windows Phone Retail' }
        '5b240fe1-2813-46f3-9391-8031ac8c6074' { 'Digital License Visual Studio Pro 2013 DLA Retail 62' }
        '08b9518c-ecf9-413b-9cc9-a4f563460a3f' { 'Digital License Visual Studio Pro 2013 DLA Retail 63' }
        '82e633ab-8bad-4352-aa30-296ffd4cdab0' { 'Digital License Visual Studio Pro 2013 DLA Retail 64' }
        '54b1b1d8-5a25-4bfe-86fa-10182efbff1a' { 'Digital License Visual Studio Pro 2013 DLA Retail 65' }
        '2f565f55-3744-4dd6-b09d-ecee0e81b453' { 'Digital License Visual Studio Pro 2013 DLA Volume:GVLK 66' }
        '15bd2fc1-fe74-4317-8919-af7455a0fbea' { 'Digital License Visual Studio Pro 2013 DLA Retail 67' }
        '1c8fa2bc-8557-4437-8876-338b3aa139cb' { 'Digital License Visual Studio Pro 2013 DLA Retail 68' }
        'c52c3c44-8b6c-4905-ac6f-b17ec8283b45' { 'Digital License Visual Studio Pro 2013 DLA Retail 69' }
        'b4f77e4b-01aa-42d8-a9ff-21a32f08328d' { 'Digital License Visual Studio Pro 2013 DLA Retail 70' }
        'c6b5595c-ba99-4a77-8433-f1133b2da767' { 'Digital License Visual Studio Pro 2013 DLA Volume:GVLK 71' }
        'ba109ed2-25ef-40c7-ba47-d3b8906c3457' { 'Digital License Visual Studio Pro 2013 DLA Retail 72' }
        '89b2710e-1dbf-44c8-9e45-c0d74a3aefd6' { 'Digital License Visual Studio Pro 2013 DLA Retail 73' }
        'e749908c-36be-4487-a649-d051edd58b63' { 'Digital License Visual Studio Pro 2013 DLA Retail 74' }
        '81f11d91-29c5-409b-af31-b29d7311ab99' { 'Digital License Visual Studio Pro 2013 DLA Retail 75' }
        'e57148da-97df-4a28-af6d-9b570a8562c1' { 'Digital License Visual Studio Pro 2013 DLA Volume:GVLK 76' }
        '21b48ea2-ba74-49c7-a627-b707ee694f28' { 'Exchange Server 2013 Hybrid Volume:GVLK' }
        '3b8db803-95d3-4257-94cd-1e2e12bce1a4' { 'Exchange Server 2013 Hybrid Volume:GVLK' }
        '327C6E89-97A1-4441-AD56-63B801C8C542' { 'Exchange Server 2013 Hybrid Volume:GVLK' }
        '49982083-024f-45e2-86f5-efbe57720be9' { 'Digital License Visual Studio Pro 2013 DLA Retail 3' }
        '3806b7dc-c775-4a04-9fde-d10fd0fa979c' { 'Digital License Visual Studio Pro 2013 DLA Retail 4' }
        '36fd8408-c20c-4d2c-bfe2-d60fc954d2a2' { 'VS Dev11 RTM Integrated Shell Retail' }
        'f4651a6c-9ccf-4f20-99c7-1d8777ddb4d5' { 'VS Dev11 RTM Integrated Shell Retail' }
        '20eaa32b-2a93-4855-936f-ab9b2fef2209' { 'Digital License Visual Studio Pro 2013 DLA Retail 1' }
        '5e923554-71e6-4e4b-a64d-36924f5b79e0' { 'Digital License Visual Studio Pro 2013 DLA Retail 2' }
        '8e83b7ad-a791-4bb7-9335-fc9bdaee1936' { 'VS Dev11 RTM Isolated Shell Retail' }
        'b2466f60-d55e-4c97-aafa-48eb7ec46715' { 'VS Dev11 RTM Isolated Shell Retail' }
        '556fed1c-2d07-479e-be32-27000c7f786a' { 'CRM 2011 Online Svr Retail' }
        '21966c3f-c4cb-44c5-9e7e-17017074c739' { 'Digital License VS Prem w/MSDN Retail 2013 DLA Retail 35' }
        '03e9ed73-b7b4-4fea-900f-2e4a25faad55' { 'Digital License VS Premium 2013 DLA Retail 33' }
        'e87465a0-b958-4a0c-b87b-71cec95142d8' { 'Digital License VS Premium 2013 DLA Retail 34' }
        '90e72f00-d31d-40f6-90e4-70dfb40992aa' { 'Digital License VS Premium 2013 DLA Retail 38' }
        '483dba54-cb70-4520-9dc4-aa9f62032cff' { 'Digital License VS Premium w/MSDN 2013 DLA Retail 36' }
        '6d3cd060-5bd2-4dca-9612-d8b89946c63b' { 'Digital License VS Premium w/MSDN 2013 DLA Volume:GVLK 37' }
        '0e434c79-8f67-409c-afc6-ca726c54b0e0' { 'VS Dev11 RTM Premium Retail' }
        '1813ee9a-c0ac-4aeb-97e8-f019646cc821' { 'VS Dev11 RTM Premium Retail' }
        '1eb9ea40-396d-4183-8612-c3fb5c02e044' { 'VS Dev11 RTM Premium Retail' }
        '79f5fec9-5dfc-4b6e-a5fb-ab49e5b6559e' { 'VS Dev11 RTM Premium Retail' }
        'a3eeb867-7d5a-48c2-b9d7-63c6306b2100' { 'VS Dev11 RTM Premium Retail' }
        '6aa7e39d-598f-4cd3-86b9-d3d97e70b519' { 'VS Dev11 RTM Premium Volume:GVLK' }
        '1534b44e-5613-496d-8e0a-1f97508a5073' { 'Digital License Visual Studio Pro 2013 DLA Retail 17' }
        'a9a255d7-aa3c-4991-bb00-6340b339fa7d' { 'Digital License Visual Studio Pro 2013 DLA Retail 18' }
        '505e22df-1ac8-4bae-8d66-4ca82bc5b320' { 'Digital License Visual Studio Pro 2013 DLA Retail 20' }
        'c46cab8d-1f77-43a0-a451-7f95202716c8' { 'Digital License Visual Studio Pro 2013 DLA Retail 26' }
        '6dae4f5f-74c1-45f2-8893-edb786379b77' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 21' }
        '3981adad-8e9e-4cc8-8984-ff1306ec2883' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 22' }
        '3d2b9c1f-518f-457f-be34-ab2d6c970b19' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 23' }
        '36fd854d-2bc2-4960-b171-d8ae5b642e8d' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 24' }
        '3c3604b3-65f6-41ec-9715-e022c59b9310' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Volume:GVLK 25' }
        '18aa3a5c-3266-4947-b2ba-3a6187ae440b' { 'Digital License VS Pro w/MSDN Retail 2013 DLA Retail 19' }
        '23688bae-4a87-493d-a2da-dda932345c61' { 'VS Dev11 RTM Professional Retail' }
        '33527d01-b9ab-405f-ade2-274af5eccbf9' { 'VS Dev11 RTM Professional Retail' }
        '393ae27f-38d3-49c1-9421-e202ebb9bda0' { 'VS Dev11 RTM Professional Retail' }
        '4c61c247-dc60-4650-bfb6-dafaf53a5f60' { 'VS Dev11 RTM Professional Retail' }
        '55a96cf9-716e-47ff-a293-a1861d6c9770' { 'VS Dev11 RTM Professional Retail' }
        '5c272f72-d581-4852-b8c6-a14b9a445a89' { 'VS Dev11 RTM Professional Retail' }
        '73f5b3bf-e811-41c4-9e31-1b1c4556f046' { 'VS Dev11 RTM Professional Retail' }
        '74ab3043-4093-4654-a5d5-928355ccfdb5' { 'VS Dev11 RTM Professional Retail' }
        '79dfccd1-4fb5-425f-b33a-3c370b1e8f17' { 'VS Dev11 RTM Professional Retail' }
        '976f5d7b-d133-4edd-b72a-95b0d5773c38' { 'VS Dev11 RTM Professional Retail' }
        '03e54764-5312-457a-ab9f-e311bfab86c1' { 'VS Dev11 RTM Professional Volume:GVLK' }
        '858bc4af-18fe-41ce-939c-6ca3fd0b38c9' { 'CRM 2011 Server Retail' }
        'bfaab35d-8747-4e8e-8c80-a170c7e711aa' { 'CRM 2011 Server Retail' }
        '15443741-95f0-4256-a968-13433dadd151' { 'CRM 2011 Server Volume:GVLK' }
        'e2405f43-efa5-44a3-8749-9e7e1aee9a0e' { 'CRM 2011 Service Provider Volume:GVLK' }
        '623d3ed3-cd92-4f80-ae18-6e91cb17219d' { 'Digital License SQL Svr Standard Edtn 2012 DLA #12 Rtl' }
        'a7796c0f-6936-4f98-95f0-075393c8ad73' { 'Digital License SQL Svr Standard Edtn 2012 DLA #6 Rtl' }
        '6c977196-6bdc-4a84-985c-def4123cb9a6' { 'Digital License SQL Svr Standard Edtn 2012 DLA #7 VL:GVLK' }
        'ffbac3d8-b8bf-4d03-879d-f510d9243265' { 'Digital License SQL Svr Standard Edtn 2012 DLA #8 OEM:NONSLP' }
        '77953e8a-d8cf-4a65-a71a-e1a3ad5d7d27' { 'Digital License SQL Svr Standard Edtn 2014 DLA 10 Retail' }
        '726e6b97-3570-42e6-aeb2-1ff8cb9f4f48' { 'Digital License SQL Svr Standard Edtn 2014 DLA 13 Retail' }
        'd20f1ab2-93ea-44af-89d1-a56b0e3677fb' { 'Digital License SQL Svr Standard Edtn 2014 DLA 7 VL GVLK' }
        '444ff436-f0e6-4f58-8793-e736eb569f7b' { 'Digital License SQL Svr Standard Edtn 2014 DLA 8 Retail' }
        'b1353f0c-56fb-4da4-9254-5b5f5f21f10f' { 'Digital License SQL Svr Standard Edtn 2014 DLA 9 OEM NONSLP' }
        '448516f0-1f1d-48a8-95d9-c955b86b2ce1' { 'Exchange Server 2013 Standard Volume:GVLK' }
        '4b1a7f4f-74bc-481d-8bab-ba129fedbe02' { 'Exchange Server 2013 Standard Volume:GVLK' }
        'DCA32113-0526-4688-8137-55AEF56FAE0D' { 'Exchange Server 2013 Standard Volume:GVLK' }
        '341adbdd-bf38-497d-9676-fc981f6ccc70' { 'Exchange Server 2013 Standard_GER Volume:GVLK' }
        '473f7ed3-d685-47c4-800b-68c40efd38d9' { 'Exchange Server 2013 Standard_GER Volume:GVLK' }
        'CFE8181E-75EE-4843-B1B0-F0DEFFDA6925' { 'Exchange Server 2013 Standard_GER Volume:GVLK' }
        '572c27ab-e70e-4233-9bd9-ac1a87be0555' { 'Digital License VS Team Explrer Everywhr 2013 DLA Retail 47' }
        'c3ebd9d6-38f7-47cd-95c8-ef8c822d92d8' { 'Digital License VS Team Explrer Everywhr 2013 DLA Retail 48' }
        '4fdd26e1-8b86-4484-9bda-2825584d7a5b' { 'VS Dev11 RTM Team Explorer Retail' }
        'f3fece98-f5f4-4695-9692-9f90a4b4af14' { 'VS Dev11 RTM Team Explorer Retail' }
        '39c8e742-81aa-442f-b347-178c719d9f71' { 'Digital License VS Team Explrer Everywhr 2013 DLA Retail 45' }
        '8ea8b385-5597-45e3-a9aa-17ae0c6af87c' { 'Digital License VS Team Explrer Everywhr 2013 DLA Retail 46' }
        'ecbb7d5f-5204-41fb-ac71-ea7f4c6f83b5' { 'VS Dev11 RTM Team Explorer Everywhere Retail' }
        'ffa28443-c03b-4090-95c5-a6643f467996' { 'VS Dev11 RTM Team Explorer Everywhere Retail' }
        '2ebc9023-9ed9-4f4f-9f60-0b9d222ad81d' { 'Digital License VS Team Foundation Svr 2013 DLA Retail 49' }
        '1edb5f37-48ea-480f-9598-1fffce55b73f' { 'Digital License VS Team Foundation Svr 2013 DLA Retail 50' }
        '1dc8c154-b595-4b2b-8fef-46168e37e1c3' { 'Digital License VS Team Foundation Svr 2013 DLA Retail 51' }
        '5a362711-ec83-4076-9e99-81854690b1ac' { 'Digital License VS Team Foundation Svr 2013 DLA Retail 52' }
        'e1527afe-b1e1-4ac7-b0d1-e5964fcd3ed3' { 'Digital License VS Team Foundation Svr 2013 DLA Retail 54' }
        '10c2b32c-2a02-4ebf-9ee6-3862dbe46296' { 'Digital License VS Team Foundation Svr 2013 DLA Retail 55' }
        'c3066dcc-4047-4796-b754-9972971855f7' { 'Digital License VS Team Foundation Svr 2013 DLA Volume:GVLK 53' }
        '0d1aafb9-8c9f-4927-9a6c-45327a661e1d' { 'VS Dev11 RTM Team Foundation Server Retail' }
        '1d40ea94-1c4f-488f-92be-0667480daa33' { 'VS Dev11 RTM Team Foundation Server Retail' }
        '65d89a58-d5f9-4197-b622-5fdf6ab28ada' { 'VS Dev11 RTM Team Foundation Server Retail' }
        'f29e675e-7b2f-4c3a-9dab-41724de63a3f' { 'VS Dev11 RTM Team Foundation Server Retail' }
        'f886680b-258c-4aa6-91ac-183de7be19bd' { 'VS Dev11 RTM Team Foundation Server Retail' }
        '9abfa09c-a0a6-46a3-b5f8-473da0348f08' { 'VS Dev11 RTM Team Foundation Server Volume:GVLK' }
        '1c7c6dc3-dc46-4a89-bf6c-0f447fd06642' { 'VS Dev11 RTM Team Foundation Server Express Retail' }
        '66858fe3-f7a8-4652-8806-b8086a085264' { 'VS Dev11 RTM Team Foundation Server Express Retail' }
        '7485f262-8b07-499a-a824-f4ae1140713f' { 'VS Dev11 RTM Team Foundation Server Express Retail' }
        '9d87d2b1-4792-4845-9d55-3241fbf03f59' { 'VS Dev11 RTM Team Foundation Server Express Retail' }
        '6d4c8ba8-e561-4aad-86d7-b260ea74b200' { 'Digital License Visual Studio Test Agent 2013 DLA Retail 58' }
        '938665a0-3029-48d8-bcf4-81f54ad9ea56' { 'Digital License Visual Studio Test Agent 2013 DLA Retail 59' }
        '6cefac0a-e165-4c78-896b-07ca9bb1f018' { 'VS Dev11 RTM Test Agent Retail' }
        'd7323986-b7e1-4fa6-82e9-8bef6831b8b9' { 'VS Dev11 RTM Test Agent Retail' }
        'b3539787-b385-4c15-9a02-0b5331caf788' { 'Digital License Visual Studio Test Agent 2013 DLA Retail 60' }
        '329a27e8-1b98-4a4b-bf6d-21d8cb731e51' { 'Digital License Visual Studio Test Agent 2013 DLA Retail 61' }
        '3c4728cf-cd95-4702-adf0-7a6288a15592' { 'VS Dev11 RTM Test Controller Retail' }
        'a476014d-6181-4e5d-a1f1-58e5e1593063' { 'VS Dev11 RTM Test Controller Retail' }
        'b40ed483-e079-453b-b1f8-c69aca88624b' { 'Digital License Visual Studio Test Pro 2013 DLA Retail 39' }
        '62264d94-e274-4a50-8019-df5d4500ed8c' { 'Digital License Visual Studio Test Pro 2013 DLA Retail 40' }
        '622be40b-5f64-4ed2-9f0a-ec1ab63420db' { 'Digital License Visual Studio Test Pro 2013 DLA Retail 44' }
        'aca62bf9-5a5a-4144-b64f-33175e96f8eb' { 'Digital License VS Test Pro w/MSDN 2013 DLA Retail 42' }
        'edb0c61b-479a-4d6a-b664-08aba376dce5' { 'Digital License VS Test Pro w/MSDN 2013 DLA Volume:GVLK 43' }
        'ded9373c-1a38-428c-8cfe-35be84a3cce9' { 'Digital License VS Test Pro wMSDN Rtl 2013 DLA Retail 41' }
        '5ec2696a-c74d-4d38-ae36-c67ec5e44032' { 'VS Dev11 RTM Test Professional Retail' }
        '62172ff1-4c0f-40fc-804b-3b07b04b3d39' { 'VS Dev11 RTM Test Professional Retail' }
        '936d3e77-e2ac-4430-9389-591afd643f46' { 'VS Dev11 RTM Test Professional Retail' }
        'a78101e7-0c09-47dd-ae5d-a8cb39c69552' { 'VS Dev11 RTM Test Professional Retail' }
        'bd4324da-8ea5-4601-a72e-6363f9bcc5f1' { 'VS Dev11 RTM Test Professional Retail' }
        '51fa90f1-d6d7-4628-886a-2f9d4ba32803' { 'VS Dev11 RTM Test Professional Volume:GVLK' }
        'd8aec0d0-3911-41b6-897e-54f4dab4fe97' { 'Digital License VS Ultimate 2013 DLA Retail 27' }
        '30a5e132-1f9e-4aec-a95d-cabbe4017fa1' { 'Digital License VS Ultimate 2013 DLA Retail 28' }
        '6314dd4d-3e27-4456-820c-943fc741598d' { 'Digital License VS Ultimate 2013 DLA Retail 32' }
        '61529311-3131-433d-8d98-b46c7aadecd4' { 'Digital License VS Ultimate w/MSDN 2013 DLA Retail 30' }
        '0c5e3b89-bac5-4f2f-bbc7-778867e447f5' { 'Digital License VS Ultimate w/MSDN 2013 DLA Volume:GVLK 31' }
        '3f2e2200-1411-489f-82e2-328d11850d2c' { 'Digital License VS Ultimate wMSDN Rtl 2013 DLA Retail 29' }
        '1a2b565f-cd71-4794-a115-8cea964d78a7' { 'VS Dev11 RTM Ultimate Retail' }
        '86999c27-1264-4c3b-b311-35274f48d49b' { 'VS Dev11 RTM Ultimate Retail' }
        '8f03944f-42c5-4cfa-aff6-b3fac950a361' { 'VS Dev11 RTM Ultimate Retail' }
        'a220c9d4-7272-4329-a94c-17cef81f3309' { 'VS Dev11 RTM Ultimate Retail' }
        'a906bce8-8b01-4b02-b147-df8cde7d2e74' { 'VS Dev11 RTM Ultimate Retail' }
        '44614c6e-cf70-4931-840b-194a0096e7ee' { 'VS Dev11 RTM Ultimate Volume:GVLK' }
        '2a2b31a4-4f56-46d0-9761-90243c2cf4ac' { 'Digital License Visual Studio Test Agent 2013 DLA Retail 56' }
        'f4c1dcf3-fcd6-4d36-b2fa-9b4b0bca01df' { 'Digital License Visual Studio Test Agent 2013 DLA Retail 57' }
        '24f9a976-109d-45a8-b3e9-6a449c4d659c' { 'VS Dev11 RTM Visual Studio Agents Retail' }
        'e7610c01-6ab8-415b-bc0f-e19e98c8226c' { 'VS Dev11 RTM Visual Studio Agents Retail' }
        '8bdbab77-bf2a-484a-9d83-edc3f5649fe7' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 77' }
        'db484ee6-dd33-471c-9201-c4dc5a52111a' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 78' }
        '5d77efbd-e9dc-4dad-92ef-813bb95f9566' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 79' }
        '50379bae-6561-4122-95e3-4a658a147ee8' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 104' }
        '4e74684f-d122-40d8-bbd5-f249c1dfbe8b' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 105' }
        '4e73ebf9-eb96-4e33-997c-04d59fd58b3a' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 106' }
        '2d1ccbe1-abbb-4343-9cd8-5681bde48e94' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 107' }
        '487a7530-f4bd-4d27-9d2f-050f930e2033' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 108' }
        'a153a6e9-1922-45f3-95d3-839d7c248967' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 109' }
        '47222d85-ef5a-4a94-8252-e4f9e6626f74' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 110' }
        'afd06ff5-df0e-4e29-9b20-af0bcaf5dcf7' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 111' }
        '36e5abe7-1f4b-4e17-af20-bbefbeea3d83' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 112' }
        '7fcd5dc6-1b1d-4f9f-8c25-5b763c12a9c5' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 113' }
        '5d9b5858-8e14-4bb7-983b-ae7a40a06297' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 114' }
        '067d8a32-b9c2-4503-a71e-f8543e79afbc' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 115' }
        'e0ada9d1-d065-48f4-acfc-43f1ef251908' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 116' }
        '0ccb64cf-c28a-409a-9fc8-3e15ad9dacdf' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 117' }
        'f75a4829-765c-4bab-9f70-2ed89e09e538' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 118' }
        '68021b36-4dd0-4f8e-9bba-896e7cc89da0' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 119' }
        '12b99695-64c6-42f3-8dd8-0f67d8ecf7e5' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 120' }
        'd9047cd9-405c-422a-827b-5c680a97f1ff' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 121' }
        '91fa4277-cfae-4d1a-948a-25dc1c8bff25' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 122' }
        '2587c423-da84-4896-92bc-d6f50de1830a' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 123' }
        'ac1dde27-b671-4026-94be-a932a309aff8' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 124' }
        '1aa5b947-0f4e-4d66-ada5-d60413497418' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 125' }
        '1e6f765e-2821-4af9-b036-b345f065dac4' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 126' }
        '4bfbd722-2fd6-4a7b-8c22-873f425c3cc8' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 127' }
        'c1eb21a5-5827-47b2-94b2-8f9250e94f9a' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 128' }
        'a22b3419-0d9f-4c52-a173-10974309bb48' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 129' }
        'a2562ebd-bc83-43bb-96e4-f4563c60f9aa' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 130' }
        '48e6f549-381a-4156-a621-8e55618e1cb8' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 131' }
        '8d65e95b-1530-4c02-88d4-f67ea082fca7' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 132' }
        'b7c0a340-7085-4495-8af7-562e33522bf5' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 133' }
        '5f2dff1a-5114-4651-887d-a4771357dc4b' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 80' }
        'cb1596e4-4535-47f2-8067-5de12216aaf1' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 81' }
        '60cf2897-1348-40d9-87d0-ce8caec5ddeb' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 82' }
        '7486a9ad-94f9-41ff-a735-fad98e101403' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 134' }
        'ff2a04b5-b277-4ff5-866f-ecf7eb928299' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 135' }
        'edce0a83-9f0c-4656-9a44-73e50d14ef49' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 136' }
        '844bda8d-dbbb-46e1-9d9d-00e1d392e5d8' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 83' }
        'ae3b5ae8-5bde-48cb-9b9a-a5b5f1c1a2fe' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 84' }
        '3b33b4fc-5d17-49dd-bfc7-f99e893e7259' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 85' }
        'ca8761bf-ee77-4448-873e-a4ecf3d2ae6c' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 86' }
        '68eff4cd-6098-4d75-8e6f-b6227e5d31bc' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 87' }
        'd883acb1-d8bb-429d-b188-6661442469e5' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 88' }
        'ae99f2f3-96f1-474e-90f5-8c19883e994d' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 89' }
        '6d6246bf-bbe0-4a03-9211-07acef081e28' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 90' }
        'e87e1930-cf1c-4ba4-82ae-61b7e2a3cb32' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 91' }
        '5a6e5ebd-1c00-43b3-9fc6-1481af1e77f3' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 92' }
        '72330a0d-81c1-4f8e-a0ac-b4d4ffe9ecbf' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 93' }
        'eb69fd4d-80e8-4726-957a-5b38defcbaf0' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 94' }
        '4ea5f2cf-fca8-4509-8a28-7179c459cff4' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 95' }
        '5d535a11-2791-4bca-8771-fd1e33ef809f' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 96' }
        '4a8d6360-2a17-4ef9-b3ae-9dc18fccd768' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 97' }
        'c9383e08-22ea-4f09-a246-7af004114d6b' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 100' }
        '5ab62112-756a-4494-8103-916680ed1e62' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 98' }
        '38c8b72e-fb6e-41ca-96d1-425059069aef' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 99' }
        'dfa874b0-721a-43b5-a6de-8a7e2df9a859' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 101' }
        '35081a4d-e79a-4b62-932b-349ec33aa79f' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 102' }
        '518a22b3-fa5d-4f33-b98d-789fa326ce4f' { 'Digital License Visual Studio Pro w/MSDN 2013 DLA Retail 103' }
        'faca9944-736c-4e97-ba57-70174ef11eb2' { 'Digital License SQL Svr Web Ed 2012 DLA #10 OEM:NONSLP' }
        'fedf9996-eb01-40b4-829b-30cff37cd0bc' { 'Digital License SQL Svr Web Ed 2012 DLA #9 VL:GVLK' }
        '301ce392-0ee5-44a8-a461-1fd479709c80' { 'Digital License SQL Svr Web Ed 2014 DLA 11 VL GVLK' }
        'b0661f74-53d4-4574-9e8e-4d8b1ef846d8' { 'Digital License SQL Svr Web Ed 2014 DLA 20 OEM NOSLP' }
        '5610b233-b8f4-4567-8af3-8306f3580370' { 'CRM 2011 Workgroup Retail' }
        '8776fd64-dfbd-4f52-9fd8-1819465a0fa9' { 'CRM 2011 Workgroup Volume:GVLK' }
        '1a9f80cb-6f23-4791-b7de-dfeb37e0919c' { 'Windows Embedded POSReady 7 POSReady OEM:COA' }
        'c6769ae2-cbd6-4813-b6f7-22fd8fd32f61' { 'Windows Embedded POSReady 7 POSReady OEM:NONSLP' }
        '93c7415c-3e5d-4dc8-a26c-023e0f8f00a1' { 'Windows Embedded POSReady 7 POSReady OEM:SLP' }
        '18ad7339-2650-459e-a35b-cbf15b109b32' { 'Windows Embedded POSReady 7 POSReady Retail' }
        'd1c316c5-7779-4580-a817-6622d3ccc02d' { 'Windows Embedded POSReady 7 POSReady Retail:TB:Eval' }
        '3980d3c2-e988-46e3-8e3e-7367c2834920' { 'Windows Embedded POSReady 7 POSReady Volume:BA' }
        'db537896-376f-48ae-a492-53d0547773d0' { 'Windows Embedded POSReady 7' }
        '9e069bbd-f940-457c-b921-a6c73a117bc5' { 'Windows Embedded POSReady 7 POSReady Volume:MAK' }
        '7e622c6b-d9bc-42d7-8bff-7f83d5716860' { 'Windows Thin PC Embedded Retail' }
        '5d087edc-5df1-4b8e-a28f-f6cd9c72d9d3' { 'Windows Thin PC Embedded Retail:TB:Eval' }
        'aa6dd3aa-c2b4-40e2-a544-a6bbb3f5c395' { 'Windows ThinPC' }
        '745b16c2-2df9-4287-aa5c-c95fda7c611d' { 'Windows Thin PC Embedded Volume:MAK' }
        '38fbe2ac-465a-4ef7-b9d8-72044f2792b6' { 'Win Next Edition Next Volume:GVLK' }
        'b7cb21c7-06bd-4f63-92dd-78db254cdcac' { 'Win Next Edition Next Volume:MAK' }
        '24259a22-3bf0-44af-a68b-1b858bce1894' { 'Win 8 RTM Enterprise;EnterpriseN;Professional;ProfessionalN Volume:CSVLK' }
        '044ba67a-4c54-47ee-941a-d6f2efaa6891' { 'Win 8 RTM Enterprise;EnterpriseN;Professional;ProfessionalN Volume:CSVLK VL Additional' }
        '29d0b60f-66da-4858-bcaf-9eb513cd310d' { 'Win 8.1 RTM Enterprise;EnterpriseN;Professional;ProfessionalN Volume:CSVLK' }
        '4614b66f-a1d7-441c-9731-23f22d0ff4e5' { 'Win 8.1 RTM Enterprise;EnterpriseN;Professional;ProfessionalN Volume:CSVLK VL Additional Lab' }
        '99cb2a2c-f7ee-48e9-98b0-ae72906c6d45' { 'Win Next Edition Next Volume:CSVLK' }
        'd521c0fd-1732-4c15-8b98-a41b2a95bbc4' { 'Win 10 Pre-Release Enterprise;EnterpriseN;Professional;ProfessionalN;EnterpriseS;EnterpriseSN;Education;EducationN Volume:CSVLK' }
        '0724cb7d-3437-4cb7-93cb-830375d0079d' { 'Win 10 RTM Enterprise;EnterpriseN;Professional;ProfessionalN;EnterpriseS;EnterpriseSN;Education;EducationN Volume:CSVLK' }
        '30a42c86-b7a0-4a34-8c90-ff177cb2acb7' { 'Win 10 RTM Enterprise;EnterpriseN;Professional;ProfessionalN;EnterpriseS;EnterpriseSN;Education;EducationN Volume:CSVLK' }
        '7a802526-4c94-4bd1-ba14-835a1aca2120' { 'Win 10 RTM Enterprise;EnterpriseN;Professional;ProfessionalN;EnterpriseS;EnterpriseSN;Education;EducationN Volume:CSVLK VL Additional Lab' }
        'd552befb-48cc-4327-8f39-47d2d94f987c' { 'Win 10 RTM Enterprise;EnterpriseN;Professional;ProfessionalN;EnterpriseS;EnterpriseSN;Education;EducationN Volume:CSVLK VL Additional Lab' }
        '2E28138A-847F-42BC-9752-61B03FFF33CD' { 'Office15_KMSHostVL_KMS_Host' }
        '98EBFE73-2084-4C97-932C-C0CD1643BEA7' { 'Office16_KMSHostVL_KMS_Host' }
        'dcb88f6f-b090-405b-850e-dabcccf3693f' { 'Windows Server 2012 R2 RTM ServerDatacenter;ServerStandard Volume:CSVLK' }
        '20e938bb-df44-45ee-bde1-4e4fe7477f37' { 'Windows Server 2012 R2 RTM ServerDatacenter;ServerStandard Volume:CSVLK for Win10' }
        'acf1b4fd-1c55-4f2d-a60b-415ac958ad88' { 'Windows Server 2012 R2 RTM ServerDatacenter;ServerStandard Volume:CSVLK VL Additional Lab' }
        '9e3fde40-d4b3-4c1d-9bde-32735aa19b39' { 'Windows Server 2012 R2 RTM ServerDatacenter;ServerStandard Volume:CSVLK VL Additional Lab for Win10' }
        'd6992aac-29e7-452a-bf10-bbfb8ccabe59' { 'Windows Server 2016 RTM ServerDatacenter;ServerStandard Volume:CSVLK' }
        '3c2da9a5-1c6e-45d1-855f-fdbef536676f' { 'Windows Server 2016 RTM ServerDatacenter;ServerStandard Volume:CSVLK VL Additional Lab' }
        'c609957a-dc23-48b3-8c6b-31b303479de2' { 'WinServer Next ServerDatacenter;ServerStandard Volume:CSVLK' }
        '7b37c913-252b-46be-ad80-b2b5ceade8af' { 'Windows Server 2012 RTM ServerDatacenter;ServerStandard;ServerMultiPointStandard;ServerMultiPointPremium Volume:CSVLK' }
        'fe27276b-a5a9-4b4d-88e3-14271beb79be' { 'Windows Server 2012 RTM ServerDatacenter;ServerStandard;ServerMultiPointStandard;ServerMultiPointPremium Volume:CSVLK VL Additional' }
        '5e63848b-ac67-4cfd-8a24-8704d28913dc' { 'Win Next Edition Next OEM:COA' }
        '87a3a0dc-5bdd-4774-8d5d-bc2cac382cae' { 'Win Next Edition Next OEM:NONSLP' }
        '8f5a4904-8ff6-4119-95be-4133b5f7f68d' { 'Win Next Edition Next OEM:SLP' }
        '6d769bbc-0de1-4b84-8c81-053792c8e155' { 'Win Next Edition Next Retail' }
        'dbdcf57b-e42b-46e5-9e30-6c9529d825f8' { 'Win Next Edition Next Retail:TB:Eval' }
        '738077d2-1299-4bda-a3af-ba5c96a8ef37' { 'Win Next Edition Next Retail:TB:Promo' }
        '6d05e585-74a7-471e-a109-6e757be94dad' { 'Win Next Edition Next Retail:TB:Sub' }
        'ef88ee1d-2254-4603-8183-d920a7982e0b' { 'Win Next Edition Next Retail:TB:Trial' }
        'd91b7562-a935-4752-a42f-f6614fe708be' { 'Windows Server 2008 R2 SP1 ServerDatacenter Retail' }
        '8402d835-3b9f-4cba-81f5-22922afa7366' { 'Windows Server 2008 R2 SP1 ServerDatacenter Retail:TB:Eval' }
        '9c135606-f8d0-4b88-8bca-78403696e1ef' { 'Server 2008 R2 SP1 DC and IA64 Volume:MAK (MAK_C)' }
        '0eee96cb-116a-4109-852a-e3797b6c4260' { 'Server 2008 R2 SP1 Web and CC Volume:MAK (MAK_A)' }
        '0cb1d6b4-3c07-487f-82fc-886d44a646aa' { 'Windows Server 2008 R2 SP1 ServerEnterprise Retail' }
        '2d727362-1f80-4a74-9e4d-e7c79826e659' { 'Windows Server 2008 R2 SP1 ServerEnterprise Retail:TB:Eval' }
        '46c2cc67-6a50-4a66-8048-9334f4a3914e' { 'Windows Server 2008 R2 SP1 ServerEnterpriseIA64 Retail:TB:Eval' }
        '47188d7c-b5ef-4336-91a9-3857b219fe95' { 'Windows Server 2008 R2 SP1 ServerStandard Retail' }
        'a7dad4b1-8065-4576-9e61-2fd025fe16cc' { 'Windows Server 2008 R2 SP1 ServerStandard Retail:TB:Eval' }
        'c60b048b-8071-4532-8398-f15f4c981861' { 'Server 2008 R2 SP1 Std and Ent Volume:MAK (MAK_B)' }
        '643144fe-8557-4a94-bc0d-5a8348398156' { 'Windows Server 2008 R2 SP1 ServerWeb Retail' }
        '01fd368f-a172-45d7-b147-273aa1aba00b' { 'Windows Server 2008 R2 SP1 ServerWeb Retail:TB:Eval' }
        '7a68f0c7-9dee-433d-b1da-e9779be95ab3' { 'Windows Server 2008 R2 SP1 Foundation Retail' }
        '4f00134f-b514-4626-a74b-a8ec7c8dfe92' { 'Windows 7 SP1 Enterprise Retail' }
        'cff07cac-7534-4cc3-b3f3-99e1a0aa3c20' { 'Windows 7 SP1 Enterprise  Volume:MAK' }
        'd24a2d0a-9cd3-4232-833f-ae3655b88425' { 'Windows 7 SP1 EnterpriseN Retail' }
        '57c2bada-4fa1-410e-b9a7-92695078d46b' { 'Windows 7 SP1 HomeBasic OEM:COA' }
        '974740ce-f7de-4f95-8404-01b53efdcb66' { 'Windows 7 SP1 HomeBasic OEM:NONSLP' }
        'baebe09a-840e-452f-9e39-df34c8d38adc' { 'Windows 7 SP1 HomeBasic OEM:SLP' }
        'e5d2c2c7-9140-4fe9-9d3d-c0b106739e34' { 'Windows 7 SP1 HomeBasic Retail' }
        '0e88bdae-f9a7-4e9d-9afe-9398459c4385' { 'Windows 7 SP1 HomeBasic Retail:WAUx' }
        'ecde36bb-22f8-481b-93ab-d3fc1204f470' { 'Windows 7 SP1 HomeBasicN OEM:COA' }
        '373a038e-d9b7-4fcb-9788-1bb41b96e8b0' { 'Windows 7 SP1 HomeBasicN OEM:NONSLP' }
        '7d39b06e-771b-41b7-9228-fe5fa91aa7a1' { 'Windows 7 SP1 HomeBasicN OEM:SLP' }
        '4beb680a-2f31-471c-a7fe-7a979ccf3d63' { 'Windows 7 SP1 HomeBasicN Retail' }
        '5e35dc43-389b-47c5-b889-2088b06738cb' { 'Windows 7 SP1 HomePremium OEM:COA' }
        'a63275f4-530c-48a7-b0d3-4f00d688d151' { 'Windows 7 SP1 HomePremium OEM:NONSLP' }
        'b8a4bb91-69b1-460d-93f8-40e0670af04a' { 'Windows 7 SP1 HomePremium OEM:SLP' }
        'ee4e1629-bcdc-4b42-a68f-b92e135f78d7' { 'Windows 7 SP1 HomePremium Retail' }
        'e68b141f-4dfa-4387-b3b7-e65c4889216e' { 'Windows 7 SP1 HomePremium Retail:WAUx' }
        'e72d9987-5c60-45b2-a093-87392e88107e' { 'Windows 7 SP1 HomePremiumN OEM:COA' }
        '153ebbcf-07f0-4fbc-b361-3b4b50f48617' { 'Windows 7 SP1 HomePremiumN OEM:NONSLP' }
        '388fee2d-04ef-4825-b442-edb6295da3d8' { 'Windows 7 SP1 HomePremiumN OEM:SLP' }
        '96b172b7-0521-413b-820b-4beb463bdac9' { 'Windows 7 SP1 HomePremiumN Retail' }
        'fddde785-e27d-4c62-8ec0-ed78e58d424f' { 'Windows 7 SP1 HomePremiumN Retail:WAUx' }
        '46d97ac9-1eab-4f29-ae77-f69d6fe70bed' { 'Windows 7 SP1 OCUR Ultimate Retail' }
        '5a79ecd8-d33f-406c-a619-7785899b5d59' { 'Windows 7 SP1 Professional OEM:COA' }
        'c33001fc-5e9c-4f27-8c05-e0154adb0db4' { 'Windows 7 SP1 Professional OEM:NONSLP' }
        'cf3c5b35-35ff-4c95-9bbd-a188e47ad14c' { 'Windows 7 SP1 Professional OEM:SLP' }
        'c1e88de3-96c4-4563-ad7d-775f65b1e670' { 'Windows 7 SP1 Professional Retail' }
        '4de78642-0f7f-4b61-9392-8add86d70ae8' { 'Windows 7 SP1 Professional Retail:TB:Sub' }
        '9ccffaf9-86a2-414e-b031-b2f777720e90' { 'Windows 7 SP1 Professional Retail:WAUx' }
        '92f9d22a-65f5-49a7-90fe-06491b4fc379' { 'Windows 7 SP1 Professional;ProfessionalN;Enterprise;EnterpriseN Volume:MAK' }
        '05bce0e7-2ed5-4876-afb3-5844ffc90f40' { 'Windows 7 SP1 ProfessionalN OEM:COA' }
        '017935c3-4ed2-427a-aedf-55129321a285' { 'Windows 7 SP1 ProfessionalN OEM:NONSLP' }
        'b20418a8-a3d4-4296-8cc0-e7ed07267a04' { 'Windows 7 SP1 ProfessionalN OEM:SLP' }
        '92f06ba8-08e1-4156-b8b5-d38328f5b5d5' { 'Windows 7 SP1 ProfessionalN Retail' }
        '01df6f02-29d6-487d-b3a1-95dcf42c10e6' { 'Windows 7 SP1 ProfessionalN Retail:TB:Sub' }
        'bc95c3ad-bb46-4b09-b130-51665ef87e3b' { 'Windows 7 SP1 ProfessionalN Retail:WAUx' }
        '8d84e167-c8ad-469f-a2b2-00b154668f70' { 'Windows 7 SP1 Starter OEM:COA' }
        'ac605e70-4f18-45ca-a99c-190e4b047cd1' { 'Windows 7 SP1 Starter OEM:NONSLP' }
        '69ffd12a-074f-4ab0-b654-99a2e278faeb' { 'Windows 7 SP1 Starter OEM:SLP' }
        '8b51f6c7-0b38-4487-83ff-bd3289c6292d' { 'Windows 7 SP1 Starter Retail' }
        '114e0c1a-1aa5-47a2-8d38-8eb3b51cdbb6' { 'Windows 7 SP1 StarterN OEM:COA' }
        '8c17fbea-5586-4807-aafe-0d8181c36ff5' { 'Windows 7 SP1 StarterN OEM:NONSLP' }
        '2e822a96-f12b-4f9a-a638-6c567060d877' { 'Windows 7 SP1 StarterN OEM:SLP' }
        '6e358ec7-1224-432e-aed8-955fb11a08bd' { 'Windows 7 SP1 StarterN Retail' }
        'bba42084-cacd-4ad4-b606-9f3d6c93b2c5' { 'Windows 7 SP1 Ultimate OEM:COA' }
        '57a232fe-0931-48fe-9389-e4586967c661' { 'Windows 7 SP1 Ultimate OEM:NONSLP' }
        'b2c4b9f6-3ee6-4a2a-a361-64ad3b61ded5' { 'Windows 7 SP1 Ultimate OEM:SLP' }
        'c619d61c-c2f2-40c3-ab3f-c5924314b0f3' { 'Windows 7 SP1 Ultimate Retail' }
        '8ec16e01-e86f-415f-b333-1819f4145294' { 'Windows 7 SP1 Ultimate Retail:TB:Sub' }
        '436cef53-8387-4692-bb4a-9492cd82260e' { 'Windows 7 SP1 Ultimate Retail:WAUx' }
        '3d30924b-bf77-489c-afbe-ecdba5988161' { 'Windows 7 SP1 UltimateN OEM:COA' }
        '628d8532-f53a-4861-a786-dd63ed6ac5b4' { 'Windows 7 SP1 UltimateN OEM:NONSLP' }
        '8bf50607-c8ce-4402-aaf8-92d2d63ab6c1' { 'Windows 7 SP1 UltimateN OEM:SLP' }
        'ada98380-2f0c-4a45-893d-d6b124e7f31b' { 'Windows 7 SP1 UltimateN Retail' }
        '4af12fad-92f3-4f32-81f7-ff44c1b6474b' { 'Windows 7 SP1 UltimateN Retail:TB:Sub' }
        'f294addd-20dd-46e6-bce7-01a15ef45e99' { 'Windows 7 SP1 UltimateN Retail:WAUx' }
        'd302d5ab-0e5e-4652-a0bb-7a776523e02a' { 'Win Next HomePremium OEM:DM' }
        '4b4c990f-31ee-46b7-929e-32389cb5bd00' { 'Win Next HomePremium OEM:SLP' }
        '9dae7ae3-db56-45cb-996a-f5632f49af3a' { 'Win Next HomePremium OEM:NONSLP' }
        '232565cb-b3fe-4de6-87ee-3b529c86a5c2' { 'Win Next HomePremium OEM:COA' }
        '2d8f6823-fa9f-4d3f-bb16-05c475ca97cd' { 'Win Next Professional OEM:DM' }
        'cfb20c87-074f-46c0-9beb-519ea4f17090' { 'Win Next Professional OEM:SLP' }
        '4c64cf62-f2d1-4ee6-98a7-bfda0e01c4aa' { 'Win Next Professional OEM:NONSLP' }
        '90f79657-e380-4bbf-a3ac-75a7f1558dcb' { 'Win Next Professional OEM:COA' }
        '92bea8b6-ac89-4fec-b644-71e279113e01' { 'WinServer Next ServerDatacenter OEM:DM' }
        'b613da48-2a03-41d2-8eb3-758d10a6f5d6' { 'WinServer Next ServerDatacenter OEM:SLP' }
        '2979826e-9d6a-47df-892f-fbbf5c09f0b7' { 'WinServer Next ServerDatacenter OEM:NONSLP' }
        '07af5a93-a13b-45dc-b8ce-c72229fce371' { 'WinServer Next ServerDatacenter OEM:COA' }
        'c76dcd25-16d1-42d4-961d-3ed260ab4c51' { 'WinServer Next ServerEnterprise OEM:DM' }
        'dabd98ff-8ae0-467d-8f49-c056916e00f0' { 'WinServer Next ServerEnterprise OEM:SLP' }
        'f241b8fe-5a32-4db1-a10e-132711b43835' { 'WinServer Next ServerEnterprise OEM:NONSLP' }
        '6995a980-91cd-4867-aa24-db3fd988c6dc' { 'WinServer Next ServerEnterprise OEM:COA' }
        'fbfcc4bf-59a1-4032-8afb-3242f763c29e' { 'WinServer Next ServerWinFoundation OEM:DM' }
        '10f19b39-9b03-4e11-af50-3e02811fe828' { 'WinServer Next ServerWinFoundation OEM:SLP' }
        'f0bf082b-4a03-4c2b-bdd5-f0040670f219' { 'WinServer Next ServerWinFoundation OEM:NONSLP' }
        '5766ed15-143d-445f-ae07-5a4f61ccacb6' { 'WinServer Next ServerWinFoundation OEM:COA' }
        '3d174e0a-e2d4-4b95-8a95-5bc5eef9ef81' { 'WinServer Next ServerStandard OEM:DM' }
        'f5c93aff-bc5a-4a73-9afc-48555edb7716' { 'WinServer Next ServerStandard OEM:SLP' }
        'e67b3237-31c0-428a-b0e4-f1fa74dc1588' { 'WinServer Next ServerStandard OEM:NONSLP' }
        'c437557d-5f33-4ecb-83ae-494015fe5a14' { 'WinServer Next ServerStandard OEM:COA' }
        '0d17ff59-c618-4007-ab49-d48c941a8bcc' { 'WinServer Next ServerWeb OEM:DM' }
        'cb20a646-4bcb-4615-820a-e832a5e79942' { 'WinServer Next ServerWeb OEM:SLP' }
        '89dda8f4-eefe-498d-9f25-201a763c0824' { 'WinServer Next ServerWeb OEM:NONSLP' }
        '793fbec3-7313-469e-bfd3-938123de3e85' { 'WinServer Next ServerWeb OEM:COA' }
        'f4259c9d-5ee7-4a0d-9754-af9627726dec' { 'Win Next Ultimate OEM:DM' }
        '4ee8edae-3ca1-4bcf-996c-aebb400baafd' { 'Win Next Ultimate OEM:SLP' }
        'ec38ef24-870f-474a-ab27-f231b5698197' { 'Win Next Ultimate OEM:NONSLP' }
        'a1425da5-4210-466b-af8a-1c9dbe926f0e' { 'Win Next Ultimate OEM:COA' }
        '18e7b54d-7cb7-462a-89b2-d48785d16cd9' { 'WinNext Beta Prerelease OEM:DM' }
        '0a16da1d-842d-4b37-8b32-27749f28ff25' { 'WinNext Beta PrereleaseARM OEM:DM' }
        '41fab9bb-d480-4494-b9d9-f9ed1f4b29fe' { 'WinServer Next ServerStorageWorkgroup OEM:DM' }
        'e8e4cc9a-5d28-4ced-b44e-4d36ecda479b' { 'WinServer Next ServerStorageStandard OEM:DM' }
        'd327b12d-39ac-41af-970b-3299c8853239' { 'WinServer Next ServerHPC OEM:DM' }
        '3bcd4e85-02cb-45a6-a123-c1f200d78c7b' { 'WinServer Next ServerMultiPointStandard OEM:DM' }
        'b6765c1c-caeb-4abe-8e26-a6c58db58433' { 'WinServer Next ServerMultiPointPremium OEM:DM' }
        '9ac91fd3-aa8a-440d-8bb4-39b7cf4dbcc2' { 'WinServerSolutions Next ServerSolution OEM:DM' }
        'e3789e86-ee91-4773-a5b8-8a90538079f0' { 'WinServerSolutions Next ServerSolutionsPremium OEM:DM' }
        '101a867e-8289-473f-84e6-c5a74a82de2e' { 'Win 8 RC CoreARM OEM:DM' }
        'b83f4f63-c52e-4d9a-a487-56da52b9f943' { 'Win 8 RC Core OEM:DM' }
        '335a4ed1-807f-444c-9c25-de3789e52ba4' { 'Win 8 RC CoreCountrySpecific OEM:DM' }
        '465b4a51-44db-43f3-b1a3-d7b6a4a65534' { 'Win 8 RC CoreN OEM:DM' }
        '4cc5c77d-0888-49bf-8b0a-4f83376d7f27' { 'Win 8 RC CoreSingleLanguage OEM:DM' }
        'b1154193-7855-4236-838d-f6fc6d161cfb' { 'Win 8 RC Professional OEM:DM' }
        '6243c975-bed9-40b4-b96e-1db8803efd0e' { 'Win 8 RC ProfessionalN OEM:DM' }
        'F8D2AA4E-180E-4423-BD7E-98B53D4320C2' { 'Office15_Alpha_AccessR_Retail' }
        '5728BFAD-20FB-408F-ACBE-395A148B0B64' { 'Office15_Alpha_MondoSubR_SubTest' }
        '8ED27E29-7414-4A95-8FFD-300B63B8ABFB' { 'Office15_Alpha_AccessRuntimeR_Bypass' }
        '8F40EBA0-E386-4C76-9129-F4BA8D0A9005' { 'Office15_Alpha_AccessSubR_Grace' }
        'B2337E3A-F4A6-4956-819A-42F43F535A39' { 'Office15_Alpha_AccessVL_MAK' }
        '44B538E2-FB34-4732-81E4-644C17D2E746' { 'Office15_Alpha_AccessVL_KMS_Client' }
        '8099D2DD-83A1-4D98-AD4F-D8624C2D5F5D' { 'Office15_Alpha_ExcelR_Retail' }
        '6E79B439-B835-4FBD-968B-B1EEDA76EEF1' { 'Office15_Alpha_ExcelSubR_Grace' }
        '902173E8-57CC-4BD2-A979-45CAFC9F31A5' { 'Office15_Alpha_ExcelSubR_Subscription' }
        '9373BFA0-97B3-4587-AB73-30934461D55C' { 'Office15_Alpha_ExcelVL_KMS_Client' }
        'B220E438-51E2-4518-B672-F56A5471F568' { 'Office15_Alpha_ExcelVL_MAK' }
        'C0FBA9A8-08A1-4693-AA21-563E70EB8AC9' { 'Office15_Alpha_VisioPremR_Retail' }
        '98D0B59C-D149-4536-80F2-ED1BDECB478F' { 'Office15_Alpha_VisioPremR_Trial' }
        '7C14A089-4C73-4692-A16E-7832326174F3' { 'Office15_Alpha_VisioPremSubR_Grace' }
        '8E444D42-C685-42A3-B33B-3E2DED5D0620' { 'Office15_Alpha_VisioPremSubR_Subscription' }
        'C53DFE17-CC00-4967-B188-A088A965494D' { 'Office15_Alpha_LyncVL_KMS_Client' }
        'BB9161CC-0DAC-4662-A3DA-94311D623375' { 'Office15_Alpha_LyncVL_MAK' }
        '53623E6A-96B4-4A01-8DE0-86C70D72A5FA' { 'Office15_Alpha_VisioProR_Retail' }
        'C7C834AC-44D4-46A3-9C6F-8E1875948988' { 'Office15_Alpha_VisioProR_Trial' }
        'A226AF49-55FE-4189-A01E-8A94A9A11B03' { 'Office15_Alpha_VisioProSubR_Grace' }
        'DEEC49E5-62A2-4245-A5FE-FDDF8F15FD8F' { 'Office15_Alpha_VisioProSubR_Subscription' }
        '8E3570AB-710B-4532-A21B-F81697F059EB' { 'Office15_Alpha_HomeStudentPreInstallR_Bypass' }
        'CFBFD60E-0B5F-427D-917C-A4DF42A80E44' { 'Office15_Alpha_VisioProVL_KMS_Client' }
        'B607E588-B35C-4FD7-AA77-43054B7B0F5C' { 'Office15_Alpha_VisioProVL_MAK' }
        '34DB0079-0193-470F-A9BB-950DD7D59CC9' { 'Office15_Alpha_VisioStdR_Retail' }
        'D4A2641B-545F-4482-B48A-7860EAA90FEB' { 'Office15_Alpha_VisioStdR_Trial' }
        '04CB3811-6309-4692-A22F-12FFD4F649AE' { 'Office15_Alpha_VisioStdSubR_Grace' }
        '28DB6F61-A973-4044-B177-05EF83EF19E0' { 'Office15_Alpha_VisioStdSubR_Subscription' }
        '7012CC81-8887-42E9-B17D-4E5E42760F0D' { 'Office15_Alpha_VisioStdVL_KMS_Client' }
        '2DF7FAC4-C06B-4E28-863F-EB8C04939C70' { 'Office15_Alpha_VisioStdVL_MAK' }
        'F7FB1607-B422-4F73-BB20-E1290F70B181' { 'Office15_Alpha_WordR_Retail' }
        '06D3B578-D6DE-4C97-B58B-589BB0457103' { 'Office15_Alpha_WordSubR_Grace' }
        '817AB549-B481-4680-A6E6-D37D382F305A' { 'Office15_Alpha_WordSubR_Subscription' }
        'DE9C7EB6-5A85-420D-9703-FFF11BDD4D43' { 'Office15_Alpha_WordVL_KMS_Client' }
        '41023570-D4E2-4BBE-839C-38478A7F0404' { 'Office15_Alpha_WordVL_MAK' }
        '3F84E134-6856-4903-A1AF-ED895E98EAAE' { 'Office15_Alpha_GrooveR_Retail' }
        'AA286EB4-556F-4EEB-967C-C1B771B7673E' { 'Office15_Alpha_GrooveVL_KMS_Client' }
        'ECC05C1A-5D79-46CC-918C-9BA812F6150C' { 'Office15_Alpha_GrooveVL_MAK' }
        'C71B3A3C-7C8D-420D-847B-EE5291D1A1C2' { 'Office15_Alpha_HomeBusinessR_Retail' }
        '4F5BD9F7-B2CB-4EFE-AA99-4901B450DEF9' { 'Office15_Alpha_HomeBusinessR_Trial' }
        'C2B225A4-26F6-453D-89EF-A5C9D79EF761' { 'Office15_Alpha_HomeBusinessSubR_Grace' }
        'B0F4E32B-E3CB-4AAE-9083-49B694F080D7' { 'Office15_Alpha_MondoSubR_SubTrial' }
        'FFED7335-E171-48E3-8DD6-42E3666F5398' { 'Office15_Alpha_MondoR_PIN' }
        '7CCC8256-FBAA-49C6-B2A9-F5AFB4257CD2' { 'Office15_Alpha_InfoPathVL_KMS_Client' }
        '3B6B93E8-5F98-4913-B5B9-004761762774' { 'Office15_Alpha_InfoPathVL_MAK' }
        'DEC8B4B4-EEC6-4F4C-9743-8348A4AD47FD' { 'Office15_Alpha_MondoR_Bypass' }
        '4E687600-4E9D-4E6D-9F41-7170E20BF664' { 'Office15_Alpha_MondoR_BypassTrial180' }
        '40BFC156-7925-4027-8897-1BB6DBE5AD27' { 'Office15_Alpha_MondoR_BypassTrial60' }
        '6312D04D-89B5-4697-B4E9-2558F2AFA452' { 'Office15_Alpha_MondoR_OEM_Perp' }
        '42D43240-BD35-4342-811E-2A27F92C6694' { 'Office15_Alpha_MondoR_Retail' }
        '80D6EB0E-BF5C-46B0-BBED-CC8FCBEFE370' { 'Office15_Alpha_MondoR_TrialDeadEnd' }
        '2D061236-8278-47EC-93A8-CFC6F369F0E6' { 'Office15_Alpha_MondoR_Trial' }
        '682877D7-C78F-496C-A012-CD605B2B2E32' { 'Office15_Alpha_MondoSubR_Grace' }
        '20865E25-9D40-43EA-87F9-0E5A76D9373A' { 'Office15_Alpha_MondoSubR_Subscription' }
        '2816A87D-E1ED-4097-B311-E2341C57B179' { 'Office15_Alpha_MondoVL_KMS_Client' }
        'DE6185D7-166C-4644-BC78-A6ECE5B619AF' { 'Office15_Alpha_MondoVL_MAK' }
        'A3B0AEB7-8FB6-441E-9C3D-D185AED3C4C4' { 'Office15_Alpha_OEM_Bypass' }
        '4D7CDC63-6D92-4C92-A83F-60E718B35A19' { 'Office15_Alpha_OfficeLPK_Bypass' }
        '793EA7A1-4739-41FE-A2FB-AF71A78A5135' { 'Office15_Alpha_OneNoteR_Retail' }
        '67C0F908-184F-4F64-8250-12DB797AB3C3' { 'Office15_Alpha_OneNoteVL_KMS_Client' }
        '619F7368-50ED-452C-A14A-E50F718824B4' { 'Office15_Alpha_OneNoteVL_MAK' }
        'FDEDB75E-24AE-45A8-83EA-D84F8E233D4E' { 'Office15_Alpha_OutlookR_Retail' }
        '7BCE4E7A-DD80-4682-98FA-F993725803D2' { 'Office15_Alpha_OutlookVL_KMS_Client' }
        '1D5021B5-4D9A-4D6D-AD96-F9AE7C00A885' { 'Office15_Alpha_OutlookVL_MAK' }
        'F8F282CE-1239-496C-AFAD-E32EDC19F6AB' { 'Office15_Alpha_PersonalPrepaidR_Trial' }
        '560DB3F8-DDF0-43D0-BAA1-BBA35C88FDCA' { 'Office15_Alpha_PersonalR_Retail' }
        '2C30BF21-5294-4734-BC99-286767869869' { 'Office15_Alpha_PowerPointR_Retail' }
        '1EC10C0A-54F6-453E-B85A-6FA1BBFEA9B7' { 'Office15_Alpha_PowerPointVL_KMS_Client' }
        '6BF1839B-180D-47AC-94BF-8243701C0FFC' { 'Office15_Alpha_PowerPointVL_MAK' }
        '57E7202D-5BD8-4382-B91A-533E1164EB33' { 'Office15_Alpha_ProfessionalAcadR_Retail' }
        'C345B5D1-1CC3-47C9-865C-9FC3E56BCD80' { 'Office15_Alpha_ProfessionalDemoR_BypassTrial180' }
        '5B2E06F9-79B2-4DCB-9AB1-A51BBBC674C9' { 'Office15_Alpha_ProfessionalR_Retail' }
        '0FA8AAB3-F3F5-4DE4-A075-BFFACAD67A5A' { 'Office15_Alpha_ProfessionalR_Trial' }
        '093D2042-9A8E-4AE4-984D-7E71A3BC7B76' { 'Office15_Alpha_ProfessionalSubR_Grace' }
        '3252DC27-6CF2-4B0C-B355-B50DAA51F761' { 'Office15_Alpha_ProfessionalSubR_Subscription' }
        'C00C6BF8-9865-495E-9625-119719E68D58' { 'Office15_Alpha_ProjectLPK_Bypass' }
        '26BBCCC0-4F80-4D18-9C21-CFAC447A7EC0' { 'Office15_Alpha_ProjectProR_Retail' }
        '539DF301-0EA1-4B66-B473-2BD593D881B2' { 'Office15_Alpha_ProjectProR_Trial' }
        '7A5965BD-5440-4F52-88D8-45E69BABA5AF' { 'Office15_Alpha_ProjectProSubR_Grace' }
        '508E6617-0D2B-4722-A564-DA0B24342ACB' { 'Office15_Alpha_ProjectProSubR_Subscription' }
        '3CFE50A9-0E03-4B29-9754-9F193F07B71F' { 'Office15_Alpha_ProjectProVL_KMS_Client' }
        '0F0FC955-9B7F-4D01-A58C-84A625477287' { 'Office15_Alpha_ProjectProVL_MAK' }
        'A3D53E55-D8E4-4261-A17D-56CDA32EB2A2' { 'Office15_Alpha_ProjectStdR_Retail' }
        'C735F338-9912-406C-A04F-EF9A00E2276D' { 'Office15_Alpha_ProjectStdR_Trial' }
        'DF511381-E5E2-4A6E-B9B6-8E5EBA8D5D58' { 'Office15_Alpha_ProjectStdSubR_Grace' }
        '5B1E918F-B0D3-42ED-A602-E7532F562567' { 'Office15_Alpha_ProjectStdSubR_Subscription' }
        '39E49E57-AE68-4EE3-B098-26480DF3DA96' { 'Office15_Alpha_ProjectStdVL_KMS_Client' }
        'FB919A1F-1F71-4869-B719-F9CC005AB637' { 'Office15_Alpha_ProjectStdVL_MAK' }
        '54517397-284B-44CB-99EB-723B39DCB3A0' { 'Office15_Alpha_ProPlusAcadVL_MAK' }
        'A3A07078-83CA-47C5-8C2B-E362AC240BD8' { 'Office15_Alpha_ProPlusSubR_Grace' }
        '82CEF0D9-D31D-456E-A3FA-AE2637EA2984' { 'Office15_Alpha_ProPlusSubR_Subscription' }
        '87D2B5BF-D47B-41FB-AF62-71C382F5CC85' { 'Office15_Alpha_ProPlusVL_KMS_Client' }
        '3A3EB072-B131-430D-8157-2A582BEB9682' { 'Office15_Alpha_ProPlusVL_MAK' }
        '147428AB-B81B-4BAF-B093-93FF1C0C01B2' { 'Office15_Alpha_PTK_Bypass' }
        '4FE044AD-6005-47D6-98E8-4A260D2C8544' { 'Office15_Alpha_PublisherR_Retail' }
        '9BCFAB7A-2613-4946-9D57-5B79C63B2DC5' { 'Office15_Alpha_PublisherSubR_Grace' }
        '32A161E4-E2CD-466A-80E0-C745DF79AEEA' { 'Office15_Alpha_PublisherSubR_Subscription' }
        '15AA2117-8F79-49A8-8317-753026D6A054' { 'Office15_Alpha_PublisherVL_KMS_Client' }
        'F3284E33-F782-4B4B-A676-36FAE730A908' { 'Office15_Alpha_PublisherVL_MAK' }
        '2C06BF34-8C97-47EA-AD4A-DED4BEFCD55B' { 'Office15_Alpha_SPDR_Bypass' }
        '96A82A03-8745-41C6-942A-25AE5A3B1452' { 'Office15_Alpha_StarterPremR_Bypass30' }
        '025010C5-698E-41F5-9BAE-858BE650574D' { 'Office15_Alpha_StarterR_Bypass' }
        '76717750-93CE-40B9-B51D-2BF2B84DB6D4' { 'Office15_Alpha_VisioLPK_Bypass' }
        '9df5d2a8-ec6b-46bc-9e89-8bd7ea507daa' { 'WinNext Beta Prerelease OEM:NONSLP' }
        '9d0bb49b-21a1-4354-9981-ec5dd9393961' { 'WinNext Beta APPXLOB For Server Editions Volume:MAK' }
        '2b9c337f-7a1d-4271-90a3-c6855a2b8a1c' { 'WinNext Beta Prerelease Volume:GVLK' }
        'f3ff9372-a1f0-4f40-b015-79a1b44cd67c' { 'WinNext Beta PrereleaseN Retail' }
        '7385fb78-9672-423d-b0b0-7107982aed6a' { 'WinNext Beta PrereleaseARM OEM:NONSLP' }
        '9ceec7ed-2c25-4a5e-97a6-acea45ad42d3' { 'WinNext Beta PrereleaseARM Retail' }
        '631ead72-a8ab-4df8-bbdf-372029989bdd' { 'WinNext Beta PrereleaseARM Volume:GVLK' }
        'a305c714-0c85-40ba-9c81-f14312305403' { 'WinNext Beta EnterpriseEval Retail:TB:Eval' }
        '82a078fa-d9e4-48d1-9274-b6fc3bf95bb9' { 'WinNext Beta EnterpriseNEval Retail:TB:Eval' }
        '3ef9a959-0ea4-4df1-b41d-1a86b39728f0' { 'WinNext Beta Ultimate Retail' }
        '0eb6e7c2-e5ff-4161-acbe-aec0c135de97' { 'WinNext Beta Professional Retail' }
        'eacd97b0-a7d4-4366-85bd-d77818fac674' { 'WinServer Next ServerStandardEval Retail:TB:Eval' }
        'bb593016-1237-4a72-a214-dbc784a30527' { 'WinServer Next ServerDatacenterEval Retail:TB:Eval' }
        '94d4be0b-23d8-42c5-8b7f-c44534fe96e3' { 'WinServer Next ServerStorageWorkgroup Retail:TB:Eval' }
        '3eb835a2-18cd-46d8-b21f-9a55fd7a3ae5' { 'WinServer Next ServerStorageWorkgroup OEM:SLP' }
        '66736b50-7916-4c89-bd40-fa1222482c89' { 'WinServer Next ServerStorageWorkgroup OEM:NONSLP' }
        '37dae7cd-0218-4f20-a4a6-fc973d66b670' { 'WinServer Next ServerStorageWorkgroup OEM:COA' }
        '25aae206-6a83-4349-8869-83bba1e4d142' { 'WinServer Next ServerStorageStandard Retail:TB:Eval' }
        'd44912a2-1e48-4763-acf5-751ae43432e5' { 'WinServer Next ServerStorageStandard OEM:SLP' }
        '719608b5-b311-4f9a-a165-4eaef60112ee' { 'WinServer Next ServerStorageStandard OEM:NONSLP' }
        '13606c16-4264-4a78-b8ef-2b4958ebe3ea' { 'WinServer Next ServerStorageStandard OEM:COA' }
        '346e71f4-f965-4f5a-84f1-be351a9aa29d' { 'WinServer Next ServerHPC Retail:TB:Eval' }
        'b55f3210-6ab8-44f3-8b0b-a9c357fe75d6' { 'WinServer Next ServerHPC OEM:SLP' }
        'e6e6e2f3-43cc-464a-872c-96d52314ccb7' { 'WinServer Next ServerHPC OEM:NONSLP' }
        '92091ac9-8508-4812-85cd-c52828eeb0ae' { 'WinServer Next ServerHPC OEM:COA' }
        '1294f2d0-4f73-4bb1-80b2-8d733baed482' { 'WinServer Next ServerHPC Volume:MAK' }
        '2412bea9-b6e0-441e-8dc2-a13720b42de9' { 'WinServer Next ServerHPC Volume:GVLK' }
        'd1fc30a7-6bd9-4942-85bd-5c825e57569d' { 'WinServer Next ServerMultiPointStandard Retail:TB:Eval' }
        '4a0e1ebe-946b-4b37-b997-ba9f929f14d9' { 'WinServer Next ServerMultiPointStandard OEM:SLP' }
        'a4257435-e853-422f-b988-1a349eeb7468' { 'WinServer Next ServerMultiPointStandard OEM:NONSLP' }
        '08e7ecc0-7611-4811-bf4e-477fb8102809' { 'WinServer Next ServerMultiPointStandard OEM:COA' }
        '92ae5b41-91fa-4dfc-afad-ebada7a86278' { 'WinServer Next ServerMultiPointStandard Volume:MAK' }
        'bfa6b683-56be-47b8-a22e-461b27b9cf11' { 'WinServer Next ServerMultiPointStandard Volume:GVLK' }
        '984bbe67-aff1-4bca-af83-490a751020c2' { 'WinServer Next ServerMultiPointPremium Retail:TB:Eval' }
        'acd7a99c-495f-42be-9484-73ae3cb9a45c' { 'WinServer Next ServerMultiPointPremium OEM:SLP' }
        'db003830-56b7-4ed5-b11a-ddf815fec8e0' { 'WinServer Next ServerMultiPointPremium OEM:NONSLP' }
        'c7327125-3ac1-4d40-b25d-d0cb4be54fcb' { 'WinServer Next ServerMultiPointPremium OEM:COA' }
        'fc23c37f-8895-4530-b327-a972dfbdc7f9' { 'WinServer Next ServerMultiPointPremium Volume:MAK' }
        'bc20fb5b-4097-484f-84d2-55b18dac95eb' { 'WinServer Next ServerMultiPointPremium Volume:GVLK' }
        '94151945-5f87-4406-9250-9fb147de6fcf' { 'WinServerSolutions Next ServerSolution Retail' }
        '2b842591-7256-4469-874a-2af1710afc0a' { 'WinServerSolutions Next ServerSolution Retail:TB:Eval' }
        'ed10a794-2497-4b00-bdd5-f4d0b98037a2' { 'WinServerSolutions Next ServerSolution OEM:SLP' }
        'b15997c6-523c-4901-83cc-9aaa4e201cd2' { 'WinServerSolutions Next ServerSolution OEM:NONSLP' }
        'b2ed5f0c-cc84-4304-be9c-1d800f1b7c9e' { 'WinServerSolutions Next ServerSolution OEM:COA' }
        '34b83d96-4771-46dc-86b3-e0f293c2746f' { 'WinServerSolutions Next ServerSolution Volume:MAK' }
        'fd288220-f61b-4b7b-8801-76b336d19c40' { 'WinServerSolutions Next ServerSolutionsPremium Retail' }
        '29a94674-1989-463e-b047-7980c942f049' { 'WinServerSolutions Next ServerSolutionsPremium Retail:TB:Eval' }
        '657133ab-8a46-4c13-b38e-71773571c8ca' { 'WinServerSolutions Next ServerSolutionsPremium OEM:SLP' }
        'd333e06e-7783-4c2d-8d1a-92b34911d531' { 'WinServerSolutions Next ServerSolutionsPremium OEM:NONSLP' }
        'de5b8609-683b-4f75-9573-a02bd192842c' { 'WinServerSolutions Next ServerSolutionsPremium OEM:COA' }
        '09af062c-e613-4085-b66e-c55b22f68dff' { 'WinServerSolutions Next ServerSolutionsPremium Volume:MAK' }
        'c3dbac02-e65b-48bc-a61e-e14befbdd674' { 'WinServer Next ServerDatacenter Retail' }
        'b2d44123-c1ec-44b6-9873-a233bb7e3618' { 'WinServer Next ServerDatacenter Retail:TB:Eval' }
        '3f701528-302a-4773-b382-9451a6c7b7c3' { 'WinServer Next ServerDatacenter Volume:MAK' }
        'ba947c44-d19d-4786-b6ae-22770bc94c54' { 'WinServer Next ServerDatacenter Volume:GVLK' }
        '965362a9-3906-4a33-a3d7-538e59975a15' { 'WinServer Next ServerEnterprise Retail' }
        '42ccd9f2-2fae-4e6b-9cc3-ea0b0e6232d7' { 'WinServer Next ServerEnterprise Retail:TB:Eval' }
        '8a409d61-30fe-4903-bdbc-1fb28603ba3a' { 'WinServer Next ServerEnterprise Volume:GVLK' }
        '8b123b6e-3576-454c-8eb7-056c36febf11' { 'WinServer Next ServerWinFoundation Retail:TB:Eval' }
        'bc085914-2b22-4128-ad91-a8d7d2ef501f' { 'WinServer Next ServerStandard Retail' }
        '94a8a35b-b757-44de-bda5-be26cb11842a' { 'WinServer Next ServerStandard Retail:TB:Eval' }
        'd3872724-5c08-4b1b-91f2-fc9eafed4990' { 'WinServer Next ServerStandard Volume:GVLK' }
        'a4e4cf4e-e8a9-450e-a046-696f87644ead' { 'WinServer Next ServerStandard Volume:MAK' }
        '1be52dfa-347b-4ea9-a5a0-903fe990a797' { 'WinServer Next ServerWeb Retail' }
        '53cfae25-4180-4d86-bfcf-ff4d1adb9caa' { 'WinServer Next ServerWeb Retail:TB:Eval' }
        '972ba9b4-65c4-47c2-9b12-febfdd2604b3' { 'WinServer Next ServerWeb Volume:MAK' }
        'e5676f13-9b66-4a1f-8b0c-43490e236202' { 'WinServer Next ServerWeb Volume:GVLK' }
        '123cdf26-dc3c-4cdd-b8b3-4fda553bb194' { 'WinServerSolutions Next ServerHomeStandard Retail' }
        '2bfe3785-af38-40a6-9060-b6810cc8ff8c' { 'WinServerSolutions Next ServerHomeStandard OEM:SLP' }
        '03567182-1dd4-4e2f-ab6b-6aea9ca843bc' { 'WinServerSolutions Next ServerHomeStandard OEM:NONSLP' }
        'b12aee12-c889-471a-b37e-208afdbb86d5' { 'WinNext Beta APPXLOB For Client Editions Volume:MAK' }
        '8e561eaf-e527-4bc4-92f4-702c7c8594b8' { 'Cassini Platform 8 Pre-Beta Embedded Retail' }
        '0d872315-eb8e-4bf4-9f9b-463ce9df80d7' { 'Cassini Platform 8 Pre-Beta Embedded Retail' }
        '6d6c13c8-91cd-470c-aa71-b2212f049e7c' { 'Cassini Platform 8 Pre-Beta Embedded Retail' }
        '162f7a33-c734-4e72-8949-60587063ecbf' { 'Cassini Platform 8 Pre-Beta Embedded Retail' }
        '974f76e1-8d4f-40cd-a259-86242468764f' { 'Cassini Platform 8 Pre-Beta Embedded Retail' }
        '6728d496-0e5a-4163-9a61-fbca3fc8530b' { 'Win 8 RC CoreARM OEM:NONSLP' }
        '38271862-6af0-4711-9d75-829e73c8c7c2' { 'Win 8 RC Core OEM:NONSLP' }
        '4b21a188-2bd9-42a3-a7aa-7349cded8316' { 'Win 8 RC CoreCountrySpecific OEM:NONSLP' }
        '864a3226-524b-49a3-a36b-a59b102195d7' { 'Win 8 RC CoreN OEM:NONSLP' }
        '421ad697-7004-4407-a789-096d8a7f376e' { 'Win 8 RC CoreSingleLanguage OEM:NONSLP' }
        '619e2810-be81-4a4c-b936-07f5ce036c31' { 'Win 8 RC Professional OEM:NONSLP' }
        'a9bd9f3f-b4cd-4880-8936-b2c9a53fb287' { 'Win 8 RC ProfessionalN OEM:NONSLP' }
        'f3508de7-5ab4-44c6-9391-26b3d2843425' { 'Win 8 RC Core Retail' }
        'c8e0f13a-8b91-4e94-871c-8012e684c90d' { 'Win 8 RC CoreN Retail' }
        '507660dd-3fc4-4df2-81f5-b559467ad56b' { 'Win 8 RC Professional Retail' }
        'cfaaaf12-448c-4e55-a5fe-b2cd4a3a96e5' { 'Win 8 RC ProfessionalN Retail' }
        '3ee91945-db02-46d7-9ad1-f646875c14a2' { 'Win 8 RC ProfessionalWMC Retail' }
        '4be4f964-08dd-4998-93eb-ca18bf674ef7' { 'Win 8 RC CoreARM Retail' }
        '72e02447-a7bc-462c-9c3d-e5c919a5140a' { 'Win 8 RC Enterprise Retail' }
        '59427d26-7f66-4d05-89b8-74c517e9fc87' { 'Win 8 RC EnterpriseN Retail' }
        '5daa3ad1-1389-44d8-a3c0-a3b6f37e62cc' { 'Win 8 RC CoreCountrySpecific Retail' }
        'cf464f7e-029f-4716-848d-d31036ee4880' { 'Win 8 RC CoreSingleLanguage Retail' }
        'a02a1fc1-cf90-4321-8dc9-35bb8dfd807f' { 'Win 8 RC EnterpriseEval Retail:TB:Eval' }
        '3f991e18-0df6-4d25-ba0b-7900aa802da2' { 'Win 8 RC EnterpriseNEval Retail:TB:Eval' }
        'ffdd27bd-30ad-4b58-ba24-c7e3b8026443' { 'Win 8 RC Professional;ProfessionalN;Enterprise;EnterpriseN Volume:MAK' }
        '77560caa-e16a-41b4-b952-739a68ba67cb' { 'Win 8 RTM CoreN Retail' }
        '625cc89b-693d-45c4-9967-123877fc41e4' { 'Win 8 RTM Core Retail' }
        '03ccfdc5-a723-45f7-ad80-5a67db815f4a' { 'Win 8 RTM ProfessionalN Retail' }
        '9e473b6d-b591-4c46-9c44-90a865f22e76' { 'Win 8 RTM Professional Retail' }
        'd9ec2828-d29e-4d1c-8fa7-bfe2c4786003' { 'Win 8 RTM ProfessionalWMC Retail' }
        '9b74255b-afe1-4da7-a143-98d1874b2a6c' { 'Win 8 RTM EnterpriseNEval Retail:TB:Eval' }
        'fbd4c5c6-adc6-4740-bc65-b2dc6dc249c1' { 'Win 8 RTM EnterpriseEval Retail:TB:Eval' }
        '949d6b86-bfa7-4ff1-b4df-17e67bb6320d' { 'Win 8 RTM Professional;ProfessionalN Volume:MAK' }
        'ebf245c1-29a8-4daf-9cb1-38dfc608a8c8' { 'Windows 8 ProfessionalN' }
        'a98bcd6d-5343-4603-8afe-5908e4611112' { 'Windows 8 Professional' }
        'e14997e7-800a-4cf7-ad10-de4b45b578db' { 'Windows 8 EnterpriseN' }
        '458e1bec-837a-45f6-b9d5-925ed5d299de' { 'Windows 8 Enterprise' }
        'b13d53d4-1a21-4d49-9eb1-20c7eafc77d4' { 'Win 8 RTM CoreN OEM:DM' }
        'a8a9d177-863c-4cdb-9064-3e3ae90016d7' { 'Win 8 RTM CoreN OEM:NONSLP' }
        'ed36b7fc-be9b-4889-b89d-0243f716df2b' { 'Win 8 RTM CoreCountrySpecific OEM:DM' }
        'f855e560-9c47-49ae-a88d-a99d1a748b88' { 'Win 8 RTM CoreCountrySpecific OEM:NONSLP' }
        '71f411ae-7b4b-41bd-b68c-c519c499f950' { 'Win 8 RTM CoreSingleLanguage OEM:DM' }
        'a25f4cc7-4bd1-4124-a4b8-4e6508dbbab8' { 'Win 8 RTM CoreSingleLanguage OEM:NONSLP' }
        '9e4b231b-3e45-41f4-967f-c914f178b6ac' { 'Win 8 RTM Core OEM:DM' }
        'c752c2e0-7c17-4af4-bba6-6f8aa1e698bc' { 'Win 8 RTM Core OEM:NONSLP' }
        '73416275-0240-425f-90d9-d92590083699' { 'Win 8 RTM ProfessionalN OEM:DM' }
        'b3e1210d-4dfe-4709-a907-de5b41b9dccd' { 'Win 8 RTM ProfessionalN OEM:NONSLP' }
        '0cdc4d08-6df6-4eb4-b5b4-a373c3e351e7' { 'Win 8 RTM Professional OEM:DM' }
        '05e80e9f-93e3-4433-8b6d-bac4ae66d7bc' { 'Win 8 RTM Professional OEM:NONSLP' }
        'ec67814b-30e6-4a50-bf7b-d55daf729d1e' { 'Win 8 RTM APPXLOB-Client Volume:MAK' }
        'be1b42f3-058d-4063-9446-87061153184b' { 'Win 8 RTM ProfessionalN Retail' }
        '7f71c90a-6279-4274-b398-37f7e9019dd4' { 'Win 8 RTM Professional Retail' }
        '7b65fea6-df35-4e65-aaa7-bdf1fef5b24f' { 'Win 8 RTM ProfessionalWMC Retail' }
        '7e324006-b4e8-4d0d-b52a-44c59af7b03f' { 'Win 8 RTM ProfessionalWMC Retail' }
        '51fac5ca-ed00-490e-8927-431f3a95bfb2' { 'MultiPoint Server 2012 RTM ServerMultiPointStandard OEM:SLP' }
        'f8c153f5-e319-4296-a308-922b83cb319a' { 'MultiPoint Server 2012 RTM ServerMultiPointStandard OEM:NONSLP' }
        '7d5486c7-e120-4771-b7f1-7b56c6d3170c' { 'Windows Server 2012 MultiPoint Standard' }
        'a9508e93-b5f5-4f8b-9a06-fe25403a4d7d' { 'MultiPoint Server 2012 RTM ServerMultiPointStandard Retail' }
        '8e4dab90-a213-4080-9e9f-6e6960f35374' { 'MultiPoint Server 2012 RTM ServerMultiPointStandard Retail:TB:Eval' }
        '2dc28392-07cb-4f61-90ae-23017b8abf51' { 'MultiPoint Server 2012 RTM ServerMultiPointStandard Volume:MAK' }
        '669c7339-15bc-48a4-8cf0-1206bf55d1a6' { 'MultiPoint Server 2012 RTM ServerMultiPointPremium OEM:SLP' }
        '34ddcc85-496f-4db1-a71f-62a9c368b902' { 'MultiPoint Server 2012 RTM ServerMultiPointPremium OEM:NONSLP' }
        '95fd1c83-7df5-494a-be8b-1300e1c9d1cd' { 'Windows Server 2012 MultiPoint Premium' }
        '536d2cc3-38f5-4b21-8172-f5ef9dba24b4' { 'MultiPoint Server 2012 RTM ServerMultiPointPremium Retail' }
        '3593786c-8910-4a34-821c-ba4d4da29c8a' { 'MultiPoint Server 2012 RTM ServerMultiPointPremium Retail:TB:Eval' }
        'c17a905d-1e69-47a0-9f3c-96b3afdeee60' { 'MultiPoint Server 2012 RTM ServerMultiPointPremium Volume:MAK' }
        'df094e87-8875-4426-af28-8f1211358e1d' { 'MultiPoint Server 2012 RTM ServerMultiPointStandard OEM:SLP (MUI locked to zh-CN)' }
        '90ff3b36-abc4-470e-848c-4437f5bbbfaa' { 'MultiPoint Server 2012 RTM ServerMultiPointStandard OEM:NONSLP (MUI locked to zh-CN)' }
        '111c9d67-815c-4c45-9473-5d85efae92d4' { 'MultiPoint Server 2012 RTM ServerMultiPointPremium OEM:SLP (MUI locked to zh-CN)' }
        'cea13691-0803-4dbd-ab10-3ef551b8db90' { 'MultiPoint Server 2012 RTM ServerMultiPointPremium OEM:NONSLP (MUI locked to zh-CN)' }
        'd365a015-4ae2-47a3-b622-c435ec68a226' { 'Storage Server 2012 RTM ServerStorageStandard OEM:SLP' }
        'e02a8dec-555e-4fba-a83d-b9d58357b8a5' { 'Storage Server 2012 RTM ServerStorageStandard OEM:NONSLP' }
        'dc436761-ec03-4520-bcc8-8faf6c6b6437' { 'Storage Server 2012 RTM ServerStorageStandard Retail' }
        'dddb6ad0-7889-479f-9234-fb0791a3a465' { 'Storage Server 2012 RTM ServerStorageStandard Volume:MAK' }
        '0de5ff31-2d62-4912-b1a8-3ea01d2461fd' { 'Storage Server 2012 RTM ServerStorageStandardEval Retail:TB:Eval' }
        '74c86e3a-132f-4a61-a262-1d9422c2b790' { 'Storage Server 2012 RTM ServerStorageWorkgroup OEM:SLP' }
        '9e82b0f6-0123-4abb-b0ca-48c66ad298eb' { 'Storage Server 2012 RTM ServerStorageWorkgroup OEM:NONSLP' }
        '4e01a8cb-6f36-42e1-8cdf-ebf46e452d18' { 'Storage Server 2012 RTM ServerStorageWorkgroup Retail' }
        '07cad638-30ec-40f7-ad44-63dbe6808a78' { 'Storage Server 2012 RTM ServerStorageWorkgroup Volume:MAK' }
        'fb08f53a-e597-40dc-9f08-8bbf99f19b92' { 'Storage Server 2012 RTM ServerStorageWorkgroupEval Retail:TB:Eval' }
        '7d7240c9-5ea0-4a33-8061-a5f44d061f2e' { 'Windows Server 2012 RTM ServerStandard Retail' }
        '38d172c7-36b3-4e4b-b435-fd0b06b95c6e' { 'Windows Server 2012 RTM ServerStandardEval Retail:TB:Eval' }
        'e8d4f6d1-e7dc-4846-8211-00c73378761c' { 'Windows Server 2012 RTM ServerStandard OEM:SLP' }
        'b56ceac0-8372-431d-9790-e8f5c3bc36d9' { 'Windows Server 2012 RTM ServerStandard OEM:NONSLP' }
        '80f31e41-6acb-44f8-84b6-f977eee1180b' { 'Windows Server 2012 RTM ServerStandard Volume:MAK' }
        'f0f5ec41-0d55-4732-af02-440a44a3cf0f' { 'Windows Server 2012 Standard' }
        'cd25b1e8-5839-4a96-a769-b6abe3aa5dee' { 'Windows Server 2012 RTM ServerDatacenterEval Retail:TB:Eval' }
        'd8c684ee-f1e0-4818-9549-94611b97e30a' { 'Windows Server 2012 RTM ServerDatacenter OEM:SLP' }
        '6b2835a6-812f-4442-92bb-8a12e39e7b3f' { 'Windows Server 2012 RTM ServerDatacenter OEM:NONSLP' }
        'dfcc0524-eb83-4602-a604-cd51ef986848' { 'Windows Server 2012 RTM ServerDatacenter Retail' }
        '92819457-c0d7-472b-916f-b9258709dea2' { 'Windows Server 2012 RTM ServerDatacenter Volume:MAK' }
        'd3643d60-0c42-412d-a7d6-52e6635327f6' { 'Windows Server 2012 Datacenter' }
        '13b49371-ed44-422a-b6ba-9b4371b1d454' { 'Windows Server 2012 RTM ServerWinFoundation OEM:SLP' }
        'e24a6dbc-cf17-42c1-8cd4-0a867174c2e3' { 'Windows Server 2012 RTM ServerWinFoundation OEM:NONSLP' }
        '72543b18-7883-4883-82cb-7a18b80faa92' { 'Windows Server 2012 RTM ServerWinFoundation Retail' }
        '3502d53e-5d43-436a-84af-714e8d334f8d' { 'Windows Server 2012 RTM APPXLOB For Server Editions Volume:MAK' }
        'e99ef7c9-df7e-4ad8-9bc2-a9c1d89a808b' { 'Windows Server 2012 RTM ServerStandard OEM:SLP (MUI locked to zh-CN)' }
        'c0cacd85-5cd9-40cf-9c30-a1ecce06211f' { 'Windows Server 2012 RTM ServerStandard OEM:NONSLP (MUI locked to zh-CN)' }
        '8b260be1-06da-4c7d-a1cc-a9703eca2e7b' { 'Windows Server 2012 RTM ServerWinFoundation OEM:SLP (MUI locked to zh-CN)' }
        '9492d0c0-3c29-4cda-a9d0-fbd8fb59d4b9' { 'Windows Server 2012 RTM ServerWinFoundation OEM:NONSLP (MUI locked to zh-CN)' }
        '6a1e73cb-6d7f-4703-811c-3b8af0f6d161' { 'Windows Server 2012 RTM ServerStandard Volume:MAK (MUI locked to zh-CN)' }
        '0767b549-b2bc-43d6-b08e-8cff71b70a9c' { 'Windows Server 2012 RTM ServerDatacenter Volume:MAK (MUI locked to zh-CN)' }
        '6592a9c1-4337-4925-91b0-e3207eb4e40c' { 'Windows Server Essentials 2012 RTM ServerSolution OEM:SLP' }
        '42e62a84-ff0d-4660-9871-ec7ebf6c5cc5' { 'Windows Server Essentials 2012 RTM ServerSolution OEM:NONSLP' }
        '0c66cd8b-b268-4891-ac36-b0693655abe5' { 'Windows Server Essentials 2012 RTM ServerSolution Retail' }
        'fd490af2-ccdf-4779-90f4-ad1da5ace1b6' { 'Windows Server Essentials 2012 RTM ServerSolution Volume:MAK' }
        '6ef03962-b897-44b9-b936-c8a630ebe6ae' { 'Windows Server Essentials 2012 RTM ServerSolution Retail:TB:Eval' }
        '0b4dbe61-245f-4b43-9ce0-bbe1db8f29ff' { 'Win 8 RTM CoreARM OEM:DM' }
        '73f32753-ba85-4b99-9beb-3b134cfffad7' { 'Windows Embedded Standard 8 RC Embedded Retail:TB:Eval' }
        'af6b4d3a-0581-4f85-83d5-ed87c0600f7e' { 'Windows Embedded Standard 8 RC Embedded Retail' }
        '9db2e1c2-91f3-4828-88f7-d30e32c6f06f' { 'Windows Embedded Standard 8 RC Embedded Retail' }
        '30cddb12-3c15-426d-bf75-01ac6b76c517' { 'Windows Embedded Standard 8 RC Embedded Retail' }
        '2b8b57d4-71fa-4861-8c86-b4c10826b30c' { 'Windows Embedded Standard 8 RC Embedded Retail' }
        '0edd9f4f-77ff-43e5-8297-19c7cafc3d01' { 'Windows Embedded Standard 8 RC Embedded Retail' }
        '6e260d42-5f13-433b-b0db-e7f9a4ab068a' { 'Windows Embedded Standard 8 RC Embedded Retail' }
        '98f1827a-79be-4945-8957-304d283c95e5' { 'Windows Embedded Standard 8 RC Embedded Retail:TB:Eval' }
        '4a8257c9-fb61-4ce5-835b-40af00e6d792' { 'Windows Embedded Standard 8 RC Embedded Retail:TB:Eval' }
        '0aa31bde-a50d-4544-9434-a8154e1f4ebe' { 'Windows Embedded Standard 8 RC Embedded Retail' }
        'a50f1053-beff-49b7-b72e-d337cc349ead' { 'Windows Embedded Standard 8 RC EmbeddedA Retail:TB:Eval' }
        'c28eefd5-8556-41a4-80fb-3cef2171fc6a' { 'Windows Embedded Standard 8 RC EmbeddedA Retail' }
        '9777ea17-3df9-420d-b18b-777a110d9f67' { 'Windows Embedded Standard 8 RC EmbeddedA Retail' }
        '98f9aebb-ff11-4d1c-a3af-bcd7f09bb778' { 'Windows Embedded Standard 8 RC EmbeddedA Retail' }
        '3c43283f-b9e9-4d90-a80c-195dbde9ebef' { 'Windows Embedded Standard 8 RC EmbeddedA Retail' }
        '78545906-7b81-4fd3-b7a2-eeaf22ba1969' { 'Windows Embedded Standard 8 RC EmbeddedA Retail' }
        'a61685cb-8274-4b28-9e5a-125457a7c3de' { 'Windows Embedded Standard 8 RC EmbeddedA Retail:TB:Eval' }
        'f3aae112-2462-4839-a918-2a82873120b4' { 'Windows Embedded Standard 8 RC EmbeddedA Retail:TB:Eval' }
        'e1ef459b-eb4c-4609-baee-9b8b3d9aa222' { 'Windows Embedded Standard 8 RC EmbeddedE Retail:TB:Eval' }
        '215f2ffd-4c88-416f-966c-0315549c5a26' { 'Windows Embedded Standard 8 RC EmbeddedE Retail' }
        'f50df763-fdd2-4700-844a-66aa8f615f73' { 'Windows Embedded Standard 8 RC EmbeddedE Retail' }
        'abb44e28-2bce-47a5-b5b7-991ca671d94c' { 'Windows Embedded Standard 8 RC EmbeddedE Retail' }
        'af1f0684-e2ee-48eb-ade8-45243019cb0e' { 'Windows Embedded Standard 8 RC EmbeddedE Retail' }
        'c6e3410d-e48d-41eb-8ca9-848397f46d02' { 'Win 8 RC CoreN Volume:GVLK' }
        'c7a8a09a-571c-4ea8-babc-0cbe4d48a89d' { 'Win 8 RC CoreCountrySpecific Volume:GVLK' }
        'b148c3f4-6248-4d2f-8c6d-31cce7ae95c3' { 'Win 8 RC CoreSingleLanguage Volume:GVLK' }
        '6496e59d-89dc-49eb-a353-09ceb9404845' { 'Windows 10 Core TechPreview' }
        'cf59a07b-1a2a-4be0-bfe0-423b5823e663' { 'Windows 10 Professional WMC TechPreview' }
        '368140cd-5170-4c86-924a-356b3dcf9da6' { 'Win 8 RC CoreARM Retail' }
        '0901f8d1-0778-4041-8d98-c0f8648a4417' { 'Windows Server 2012 RC ServerStorageStandardEval Retail:TB:Eval' }
        '1c4e278c-407d-482e-932d-f71f28a2aeb0' { 'Windows Server 2012 RC ServerStorageWorkgroupEval Retail:TB:Eval' }
        '3a9a9414-24bf-4836-866d-ba13a298efb0' { 'Win 8 RC CoreARM Volume:GVLK' }
        '197390a0-65f6-4a95-bdc4-55d58a3b0253' { 'Windows 8 CoreN' }
        '9d5584a2-2d85-419a-982c-a00888bb9ddf' { 'Win 8 RTM CoreCountrySpecific Volume:GVLK' }
        '8860fcd4-a77b-4a20-9045-a150ff11d609' { 'Win 8 RTM CoreSingleLanguage Volume:GVLK' }
        'c04ed6bf-55c8-4b47-9f8e-5a1f31ceee60' { 'Windows 8 Core' }
        'a00018a3-f20f-4632-bf7c-8daa5351c914' { 'Windows 8 Professional WMC' }
        'af35d7b7-5035-4b63-8972-f0b747b9f4dc' { 'Win 8 RTM CoreARM Volume:GVLK' }
        '4c0a50bf-4308-45e8-95c9-05759dc0de15' { 'Win 8 RTM CoreARM Retail' }
        'dc76fecf-f339-42b7-b9b7-3b0958c3c020' { 'Win 8 RTM CoreCountrySpecific Retail' }
        '1bb82acd-c4ad-4566-813c-55840d559460' { 'Win 8 RTM CoreSingleLanguage Retail' }
        'b0f8a518-2c58-4eb8-9319-084f0eb4ddc4' { 'Win 8 RTM CoreSingleLanguage OEM:DM' }
        'bf4b3af6-c071-496d-bfcc-5f0dc12c7798' { 'Win 8 RTM Core OEM:DM' }
        'bbc56067-37f8-49dd-87b2-a418a9ba130a' { 'Win 8 RTM Professional OEM:DM' }
        '8117933e-0789-49b9-a410-bb27c930825e' { 'Windows Embedded Industry 8 TAP-CTP' }
        '20932bd1-9599-4553-babe-3b49e6378129' { 'Windows Embedded Industry 8 TAP-CTP' }
        '311689ec-557a-48b1-b913-15f800a4b3b8' { 'Windows Embedded Industry 8 TAP-CTP' }
        'c8cca3ca-bea8-4f6f-87e0-4d050ce8f0a9' { 'Windows Embedded Industry 8 TAP-CTP' }
        '5b394fbc-3997-459d-8a69-135c482b6d9e' { 'Windows Embedded Industry 8 TAP-CTP' }
        '58E55634-63D9-434A-8B16-ADE5F84737B8' { 'Office15_O365SmallBusPremR_PIN' }
        '12F1FDF0-D744-48B6-9F9A-B3D7744BEEB5' { 'Office15_O365HomePremR_PIN2' }
        '0C7137CB-463A-44CA-B6CD-F29EAE4A5201' { 'Office15_O365HomePremR_PIN1' }
        '21757D20-006A-4BA0-8FDB-9DE272A11CF4' { 'Office15_O365HomePremR_PIN3' }
        'B6C0DE84-37D8-41B2-9EAF-8A80A008D58A' { 'Office15_O365HomePremR_PIN4' }
        '16C432FF-E13E-46A5-AB7D-A1CE7519119A' { 'Office15_O365HomePremR_PIN5' }
        'C9D3D19B-60A6-4213-BC72-C1A1A59DC45B' { 'Office15_O365HomePremR_PIN6' }
        'B64CFCED-19A0-4C81-8B8D-A72DDC7488BA' { 'Office15_O365HomePremR_PIN7' }
        'F8FF7F1C-1D40-4B84-9535-C51F7B3A70D0' { 'Office15_O365HomePremR_PIN8' }
        '77A58083-E86D-45C1-B56E-77EC925167CF' { 'Office15_O365HomePremR_PIN9' }
        'EB778317-EA9A-4FBC-8351-F00EEC82E423' { 'Office15_O365HomePremR_PIN10' }
        '9CF873F3-5112-4C73-86C5-B94808F675E0' { 'Office15_O365HomePremR_PIN11' }
        '949594B8-4FBF-44A7-BD8D-911E25BA2938' { 'Office15_O365HomePremR_PIN12' }
        '2A859A5B-3B1F-43EA-B3E3-C1531CC23363' { 'Office15_O365HomePremR_PIN13' }
        '5B7C4417-66C2-46DB-A2AF-DD1D811D8DCA' { 'Office15_O365HomePremR_PIN14' }
        '7E6F537B-AF16-43E6-B07F-F457A96F58FE' { 'Office15_O365HomePremR_PIN15' }
        'AE88E21A-D981-45A0-9813-3452F5390A1E' { 'Office15_O365HomePremR_PIN16' }
        '09322079-6043-4D33-9AB1-FFC268B8248E' { 'Office15_O365HomePremR_PIN17' }
        'E0C4D41F-B115-4D51-9E8C-63AF19B6EEB8' { 'Office15_O365HomePremR_PIN18' }
        '5917FA4B-7A37-4D70-B835-2755CF165E01' { 'Office15_O365HomePremR_PIN19' }
        '80C94D2C-4DDE-47AE-82D2-A2ADDE81E653' { 'Office15_AccessR_Grace' }
        '70E3A52B-E7DA-4ABE-A834-B403A5776532' { 'Office15_AccessR_OEM_Perp' }
        'AB4D047B-97CF-4126-A69F-34DF08E2F254' { 'Office15_AccessR_Retail' }
        'E2E45C14-401F-4955-B05C-B6BDA44BF303' { 'Office15_AccessR_Trial' }
        '259DE5BE-492B-44B3-9D78-9645F848F7B0' { 'Office15_AccessRuntimeR_Bypass' }
        '6EE7622C-18D8-4005-9FB7-92DB644A279B' { 'Office Access 2013' }
        '4374022D-56B8-48C1-9BB7-D8F2FC726343' { 'Office15_AccessVL_MAK' }
        '360E9813-EA13-4152-B020-B1D0BBF1AC17' { 'Office15_ExcelR_Grace' }
        '72D74828-C6B2-420B-AC78-68BF3A0E882C' { 'Office15_ExcelR_OEM_Perp' }
        '1B1D9BD5-12EA-4063-964C-16E7E87D6E08' { 'Office15_ExcelR_Retail' }
        '5290A34F-2DE8-4965-B53A-2D2976CB7B35' { 'Office15_ExcelR_Trial' }
        'F7461D52-7C2B-43B2-8744-EA958E0BD09A' { 'Office Excel 2013' }
        'AC1AE7FD-B949-4E04-A330-849BC40638CF' { 'Office15_ExcelVL_MAK' }
        '323277B1-D81D-4329-973E-497F413BC5D0' { 'Office15_GrooveR_Grace' }
        'CFAF5356-49E3-48A8-AB3C-E729AB791250' { 'Office15_GrooveR_Retail' }
        '7868FC3D-ABA3-4B5D-B4EA-419C608DAB45' { 'Office15_GrooveR_Trial' }
        'FB4875EC-0C6B-450F-B82B-AB57D8D1677F' { 'Office15_GrooveVL_KMS_Client' }
        '4825AC28-CE41-45A7-9E6E-1FED74057601' { 'Office15_GrooveVL_MAK' }
        '8D071DB8-CDE7-4B90-8862-E2F6B54C91BF' { 'Office15_HomeBusinessDemoR_BypassTrial180' }
        '0900883A-7F90-4A04-831D-69B5881A0C1C' { 'Office15_HomeBusinessR_Grace' }
        '1E69B3EE-DA97-421F-BED5-ABCCE247D64E' { 'Office15_HomeBusinessR_OEM_Perp' }
        'CD256150-A898-441F-AAC0-9F8F33390E45' { 'Office15_HomeBusinessR_Retail' }
        'A2B90E7A-A797-4713-AF90-F0BECF52A1DD' { 'Office15_HomeBusinessR_Subscription' }
        'F5BEB18A-6861-4625-A369-9C0A2A5F512F' { 'Office15_HomeBusinessR_SubTest' }
        '92847EEE-6935-4585-817D-14DCFFE6F607' { 'Office15_HomeBusinessR_SubTrial' }
        'BB8DF749-885C-47D8-B33A-7E5A402EF4A3' { 'Office15_HomeBusinessR_Trial' }
        '6330BD12-06E5-478A-BDF4-0CD90C3FFE65' { 'Office15_HomeStudentDemoR_BypassTrial180' }
        '1FDFB4E4-F9C9-41C4-B055-C80DAF00697D' { 'Office15_HomeStudentPreInstallR_OEM_ARM' }
        'CE6A8540-B478-4070-9ECB-2052DD288047' { 'Office15_HomeStudentR_Grace' }
        'BE465D55-C392-4D67-BF45-4DE7829EFC6E' { 'Office15_HomeStudentR_OEM_Perp' }
        '98685D21-78BD-4C62-BC4F-653344A63035' { 'Office15_HomeStudentR_Retail' }
        'F2DE350D-3028-410A-BFAE-283E00B44D0E' { 'Office15_HomeStudentR_Subscription' }
        'F3F68D9F-81E5-4C7D-9910-0FD67DC2DDF2' { 'Office15_HomeStudentR_SubTest' }
        'D46BBFF5-987C-4DAC-9A8D-069BAC23AE2A' { 'Office15_HomeStudentR_SubTrial' }
        '6CA43757-B2AF-4C42-9E28-F763C023EDC8' { 'Office15_HomeStudentR_Trial' }
        'FBE35AC1-57A8-4D02-9A23-5F97003C37D3' { 'Office15_InfoPathR_Grace' }
        '44984381-406E-4A35-B1C3-E54F499556E2' { 'Office15_InfoPathR_Retail' }
        'EAB6228E-54F9-4DDE-A218-291EA5B16C0A' { 'Office15_InfoPathR_Trial' }
        'A30B8040-D68A-423F-B0B5-9CE292EA5A8F' { 'Office InfoPath 2013' }
        '9E016989-4007-42A6-8051-64EB97110CF2' { 'Office15_InfoPathVL_MAK' }
        'FF693BF4-0276-4DDB-BB42-74EF1A0C9F4D' { 'Office15_LyncEntryR_PrepidBypass' }
        '0EA305CE-B708-4D79-8087-D636AB0F1A4D' { 'Office15_LyncR_Grace' }
        'FADA6658-BFC6-4C4E-825A-59A89822CDA8' { 'Office15_LyncR_Retail' }
        '6A88EBA4-8B91-4553-8764-61129E1E01C7' { 'Office15_LyncR_Trial' }
        '0FBDE535-558A-4B6E-BDF7-ED6691AA7188' { 'Office15_LyncVDI_Bypass' }
        '1B9F11E3-C85C-4E1B-BB29-879AD2C909E3' { 'Office Lync 2013' }
        'E1264E10-AFAF-4439-A98B-256DF8BB156F' { 'Office15_LyncVL_MAK' }
        '1C3432FE-153B-439B-82CC-FB46D6F5983A' { 'Office15_MondoR_BypassTrial180' }
        'E1F5F599-D875-48CA-93C4-E96C473B29E7' { 'Office15_MondoR_Grace' }
        '6E2F71BC-1BA0-4620-872E-285F69C3141E' { 'Office15_MondoR_OEM_Perp' }
        '3169C8DF-F659-4F95-9CC6-3115E6596E83' { 'Office15_MondoR_Retail' }
        '69EC9152-153B-471A-BF35-77EC88683EAE' { 'Office15_MondoR_Subscription' }
        '9E7FE6CF-58C6-4F36-9A1B-9C0BFC447ED5' { 'Office15_MondoR_SubTest' }
        '26421C15-1B53-4E53-B303-F320474618E7' { 'Office15_MondoR_SubTrial' }
        '2DA73A73-4C36-467F-8A2D-B49090D983B7' { 'Office15_MondoR_Trial' }
        'DC981C6B-FC8E-420F-AA43-F8F33E5C0923' { 'Office Mondo 2013' }
        'F33485A0-310B-4B72-9A0E-B1D605510DBD' { 'Office15_MondoVL_MAK' }
        'C5D855EE-F32B-4A1C-97A8-F0A28CE02F9C' { 'Office15_MOSS_Bypass' }
        'CBF97833-C73A-4BAF-9ED3-D47B3CFF51BE' { 'Office15_MOSS_BypassTrial180' }
        'B695D087-638E-439A-8BE3-57DB429D8A77' { 'Office15_MOSSFISEnt_Bypass' }
        '2F05F7AA-6FF7-49AB-884A-14696A7BD1A4' { 'Office15_MOSSFISEnt_BypassTrial180' }
        '2CD676C7-3937-4AC7-B1B5-565EDA761F13' { 'Office15_MOSSFISStd_Bypass' }
        '062FDB4F-3FCB-4A53-9B36-03262671B841' { 'Office15_MOSSFISStd_BypassTrial180' }
        'B7D84C2B-0754-49E4-B7BE-7EE321DCE0A9' { 'Office15_MOSSPremium_Bypass' }
        '298A586A-E3C1-42F0-AFE0-4BCFDC2E7CD0' { 'Office15_MOSSPremium_BypassTrial180' }
        'D7279DD0-E175-49FE-A623-8FC2FC00AFC4' { 'Office15_O365HomePremR_Grace' }
        '537EA5B5-7D50-4876-BD38-A53A77CACA32' { 'Office15_O365HomePremR_Subscription1' }
        '52287AA3-9945-44D1-9046-7A3373666821' { 'Office15_O365HomePremR_Subscription2' }
        'C85FE025-B033-4F41-936B-B121521BA1C1' { 'Office15_O365HomePremR_Subscription3' }
        'B58A5943-16EA-420F-A611-7B230ACD762C' { 'Office15_O365HomePremR_Subscription4' }
        '28F64A3F-CF84-46DA-B1E8-2DFA7750E491' { 'Office15_O365HomePremR_Subscription5' }
        'A96F8DAE-DA54-4FAD-BDC6-108DA592707A' { 'Office15_O365HomePremR_SubTest1' }
        '77F47589-2212-4E3B-AD27-A900CE813837' { 'Office15_O365HomePremR_SubTest2' }
        '96353198-443E-479D-9E80-9A6D72FD1A99' { 'Office15_O365HomePremR_SubTest3' }
        'B4AF11BE-5F94-4D8F-9844-CE0D5E0D8680' { 'Office15_O365HomePremR_SubTest4' }
        '4C1D1588-3088-4796-B3B2-8935F3A0D886' { 'Office15_O365HomePremR_SubTest5' }
        '951C0FE6-40A8-4400-8003-EEC0686FFBC4' { 'Office15_O365HomePremR_SubTrial1' }
        'FB3540BC-A824-4C79-83DA-6F6BD3AC6CCB' { 'Office15_O365HomePremR_SubTrial2' }
        '86AF9220-9D6F-4575-BEF0-619A9A6AA005' { 'Office15_O365HomePremR_SubTrial3' }
        'AE9D158F-9450-4A0C-8C80-DD973C58357C' { 'Office15_O365HomePremR_SubTrial4' }
        '95820F84-6E8C-4D22-B2CE-54953E9911BC' { 'Office15_O365HomePremR_SubTrial5' }
        '3AD61E22-E4FE-497F-BDB1-3E51BD872173' { 'Office15_O365ProPlusR_Grace' }
        '0C4E5E7A-B436-4776-BB89-88E4B14687E2' { 'Office15_O365ProPlusR_Retail' }
        '149DBCE7-A48E-44DB-8364-A53386CD4580' { 'Office15_O365ProPlusR_Subscription1' }
        'E3DACC06-3BC2-4E13-8E59-8E05F3232325' { 'Office15_O365ProPlusR_Subscription2' }
        'A8119E32-B17C-4BD3-8950-7D1853F4B412' { 'Office15_O365ProPlusR_Subscription3' }
        '6E5DB8A5-78E6-4953-B793-7422351AFE88' { 'Office15_O365ProPlusR_Subscription4' }
        'FF02E86C-FEF0-4063-B39F-74275CDDD7C3' { 'Office15_O365ProPlusR_Subscription5' }
        '46D2C0BD-F912-4DDC-8E67-B90EADC3F83C' { 'Office15_O365ProPlusR_SubTrial1' }
        '26B6A7CE-B174-40AA-A114-316AA56BA9FC' { 'Office15_O365ProPlusR_SubTrial2' }
        'B6B47040-B38E-4BE2-BF6A-DABF0C41540A' { 'Office15_O365ProPlusR_SubTrial3' }
        'E538D623-C066-433D-A6B7-E0708B1FADF7' { 'Office15_O365ProPlusR_SubTrial4' }
        'DFC5A8B0-E9FD-43F7-B4CA-D63F1E749711' { 'Office15_O365ProPlusR_SubTrial5' }
        '8DED1DA3-5206-4540-A862-E8473B65D742' { 'Office15_O365SmallBusPremR_Grace' }
        '7A75647F-636F-4607-8E54-E1B7D1AD8930' { 'Office15_O365SmallBusPremR_Retail' }
        'BACD4614-5BEF-4A5E-BAFC-DE4C788037A2' { 'Office15_O365SmallBusPremR_Subscription1' }
        '0BC1DAE4-6158-4A1C-A893-807665B934B2' { 'Office15_O365SmallBusPremR_Subscription2' }
        '65C607D5-E542-4F09-AD0B-40D6A88B2702' { 'Office15_O365SmallBusPremR_Subscription3' }
        '4CB3D290-D527-45C2-B079-26842762FDD3' { 'Office15_O365SmallBusPremR_Subscription4' }
        '881D148A-610E-4F0A-8985-3BE4C0DB2B09' { 'Office15_O365SmallBusPremR_Subscription5' }
        '6AE65B85-E04E-4368-80A7-786D5766325E' { 'Office15_O365SmallBusPremR_SubTrial1' }
        '2030A84D-D6C7-4968-8CEC-CF4737ACC337' { 'Office15_O365SmallBusPremR_SubTrial2' }
        '2F756D47-E1B1-4D2A-922B-4D76F35D007D' { 'Office15_O365SmallBusPremR_SubTrial3' }
        'C5A706AC-9733-4061-8242-28EB639F1B29' { 'Office15_O365SmallBusPremR_SubTrial4' }
        '090506FC-50F8-4C00-B8C7-91982A2A7C99' { 'Office15_O365SmallBusPremR_SubTrial5' }
        '12275A09-FEC0-45A5-8B59-446432F13CD6' { 'Office15_OfficeLPK_Bypass' }
        'FD97BCB1-8F3C-4185-91D2-A2AB7EE278C2' { 'Office15_OneNoteR_Grace' }
        'BA6BA8B7-2A1D-4659-BA45-4BAC007B1698' { 'Office15_OneNoteR_OEM_Perp' }
        '8B524BCC-67EA-4876-A509-45E46F6347E8' { 'Office15_OneNoteR_Retail' }
        'B6DDD089-E96F-43F7-9A77-440E6F3CD38E' { 'Office15_OneNoteR_Trial' }
        'EFE1F3E6-AEA2-4144-A208-32AA872B6545' { 'Office OneNote 2013' }
        'B067E965-7521-455B-B9F7-C740204578A2' { 'Office15_OneNoteVL_MAK' }
        'A3A4593B-97DC-4364-9910-70202AF2D0B5' { 'Office15_OutlookR_Grace' }
        'A1B2DD4A-29DD-4B74-A6FE-BF3463C00F70' { 'Office15_OutlookR_OEM_Perp' }
        '12004B48-E6C8-4FFA-AD5A-AC8D4467765A' { 'Office15_OutlookR_Retail' }
        'AF3A9181-8B97-4B28-B2B1-A7AC6F8C3A05' { 'Office15_OutlookR_Trial' }
        '771C3AFA-50C5-443F-B151-FF2546D863A0' { 'Office OutLook 2013' }
        '8D577C50-AE5E-47FD-A240-24986F73D503' { 'Office15_OutlookVL_MAK' }
        'B845985D-10AE-449A-96AF-43CEDCE9363D' { 'Office15_PersonalDemoR_BypassTrial180' }
        'A75ADD9F-3982-464D-93FE-7D3BEC07FB46' { 'Office15_PersonalR_Grace' }
        '1EFD9BEC-770F-4F5D-BC66-138ACAF5019E' { 'Office15_PersonalR_OEM_Perp' }
        '17E9DF2D-ED91-4382-904B-4FED6A12CAF0' { 'Office15_PersonalR_Retail' }
        '621292D6-D737-40F8-A6E8-A9D0B852AEC2' { 'Office15_PersonalR_Trial' }
        '1DC00701-03AF-4680-B2AF-007FFC758A1F' { 'Office15_MondoR_KMS_Automation' }
        'C86F17B4-67E0-459E-B785-F09FF54600E4' { 'Office15_MondoPreInstallR_OEM_ARM' }
        'F3A4939A-92A7-47CC-9D05-7C7DB72DD968' { 'Office15_PowerPointR_Grace' }
        'AC867F78-3A34-4C70-8D80-53B6F8C4092C' { 'Office15_PowerPointR_OEM_Perp' }
        '31743B82-BFBC-44B6-AA12-85D42E644D5B' { 'Office15_PowerPointR_Retail' }
        '52C5FBED-8BFB-4CB4-8BFF-02929CD31A98' { 'Office15_PowerPointR_Trial' }
        '8C762649-97D1-4953-AD27-B7E2C25B972E' { 'Office PowerPoint 2013' }
        'E40DCB44-1D5C-4085-8E8F-943F33C4F004' { 'Office15_PowerPointVL_MAK' }
        '42C3EF3F-AB7C-482A-8060-B2E57B25D4BA' { 'Office15_ProfessionalDemoR_BypassTrial180' }
        'A9419E0F-8A3F-4E58-A143-E4B4803F85D2' { 'Office15_ProfessionalR_Grace' }
        '3178076B-5F4E-4ACE-A160-8AAE7F002944' { 'Office15_ProfessionalR_OEM_Perp' }
        '44BC70E2-FB83-4B09-9082-E5557E0C2EDE' { 'Office15_ProfessionalR_Retail' }
        '1FCA7624-3A67-4A02-9EF3-6C363E35C8CD' { 'Office15_ProfessionalR_Trial' }
        '781038A1-800F-4DDF-AB26-70A98774F8AD' { 'Office15_ProjectLPK_Bypass' }
        '4031E9F3-E451-4E18-BEDD-91CAA3690C91' { 'Office15_ProjectProCO365R_Subscription' }
        'AE1310F8-2F53-4994-93A3-C61502E91D04' { 'Office15_ProjectProCO365R_SubTest' }
        '2B456DC8-145A-4D2D-9C72-703D1CD8C50E' { 'Office15_ProjectProCO365R_SubTrial' }
        '40E9B240-879B-4BA4-BFB0-2E94CA998EEB' { 'Office15_ProjectProDemoR_BypassTrial180' }
        'A1D1EFF9-1301-4709-BC2C-B6FCE5C158D8' { 'Office15_ProjectProMSDNR_Retail' }
        '2F72340C-B555-418D-8B46-355944FE66B8' { 'Office15_ProjectProO365R_Subscription' }
        '539165C6-09E3-4F4B-9C29-EEC86FDF545F' { 'Office15_ProjectProO365R_SubTest' }
        '330A4ACE-9CC1-4AF5-8D36-8D0681194618' { 'Office15_ProjectProO365R_SubTrial' }
        'AE7B1E26-3AEE-4FE3-9C5B-88F05E36CD34' { 'Office15_ProjectProR_Grace' }
        '3B5C7D36-1314-41C0-B405-15C558435F7D' { 'Office15_ProjectProR_OEM_Perp' }
        'F2435DE4-5FC0-4E5B-AC97-34F515EC5EE7' { 'Office15_ProjectProR_Retail' }
        '41937580-5DDD-4806-9089-5266D567219F' { 'Office15_ProjectProR_Trial' }
        '4A5D124A-E620-44BA-B6FF-658961B33B9A' { 'Office Project Pro 2013' }
        'ED34DC89-1C27-4ECD-8B2F-63D0F4CEDC32' { 'Office15_ProjectProVL_MAK' }
        '35466B1A-B17B-4DFB-A703-F74E2A1F5F5E' { 'Office15_ProjectServer_Bypass' }
        'BC7BAF08-4D97-462C-8411-341052402E71' { 'Office15_ProjectServer_BypassTrial180' }
        '053D3F49-B913-4B33-935E-F930DECD8709' { 'Office15_ProjectStdCO365R_Subscription' }
        '594E9433-6492-434D-BFCE-4014F55D3909' { 'Office15_ProjectStdCO365R_SubTest' }
        'B480F090-28FE-4A67-8885-62322037A0CD' { 'Office15_ProjectStdCO365R_SubTrial' }
        '58D95B09-6AF6-453D-A976-8EF0AE0316B1' { 'Office15_ProjectStdO365R_Subscription' }
        '5DF83BED-7E8E-4A28-80EF-D8B0A004CF3E' { 'Office15_ProjectStdO365R_SubTest' }
        '75F08E14-5CF5-4D59-9CEF-DA3194B6FD24' { 'Office15_ProjectStdO365R_SubTrial' }
        '6883893B-9DD9-4943-ACEB-58327AFDC194' { 'Office15_ProjectStdR_Grace' }
        '519FBBDE-79A6-4793-8A84-57F6541579C9' { 'Office15_ProjectStdR_OEM_Perp' }
        '5517E6A2-739B-4822-946F-7F0F1C5934B1' { 'Office15_ProjectStdR_Retail' }
        '427A28D1-D17C-4ABF-B717-32C780BA6F07' { 'Office Project Standard 2013' }
        '2B9E4A37-6230-4B42-BEE2-E25CE86C8C7A' { 'Office15_ProjectStdVL_MAK' }
        '82E42CB5-1741-46FB-8F2F-AC8414741E8D' { 'Office15_ProPlusDemoR_BypassTrial180' }
        '41499869-4103-4D3B-9DA6-D07DF41B6E39' { 'Office15_ProPlusMSDNR_Retail' }
        '1B686580-9FB1-4B88-BFBA-EAE7C0DA31AD' { 'Office15_ProPlusR_Grace' }
        'BB00F022-69DA-4BE3-968D-D9BCD41CF814' { 'Office15_ProPlusR_OEM_Perp' }
        '064383FA-1538-491C-859B-0ECAB169A0AB' { 'Office15_ProPlusR_Retail' }
        'DB56DEC3-34F2-4BC5-A7B9-ECC3CC51C12A' { 'Office15_ProPlusR_Trial' }
        'B322DA9C-A2E2-4058-9E4E-F59A6970BD69' { 'Office Professional Plus 2013' }
        '2B88C4F2-EA8F-43CD-805E-4D41346E18A7' { 'Office15_ProPlusVL_MAK' }
        '86E17AEA-A932-42C4-8651-95DE6CB37A08' { 'Office15_PTK_Bypass' }
        'DB8E8683-A848-473B-B2E7-D1DE4D042095' { 'Office15_PublisherR_Grace' }
        'CC802B96-22A4-4A90-8757-2ABB7B74484A' { 'Office15_PublisherR_OEM_Perp' }
        'C3A0814A-70A4-471F-AF37-2313A6331111' { 'Office15_PublisherR_Retail' }
        '615FEE6D-2E96-487F-98B2-51A892788A70' { 'Office15_PublisherR_Trial' }
        '00C79FF1-6850-443D-BF61-71CDE0DE305F' { 'Office Publisher 2013' }
        '38EA49F6-AD1D-43F1-9888-99A35D7C9409' { 'Office15_PublisherVL_MAK' }
        '7930E9BD-12B8-4B32-88CE-733B4A594EDF' { 'Office15_ServerLPK_Bypass' }
        'BA3E3833-6A7E-445A-89D0-7802A9A68588' { 'Office15_SPDFreeR_PrepidBypass' }
        'A884AB66-DE2E-4505-BA8B-3FB9DAF149ED' { 'Office15_StandardMSDNR_Retail' }
        '370155F7-D1EC-4B8B-9FBA-EE8ACC6E0BB7' { 'Office15_StandardR_Grace' }
        '32255C0A-16B4-4CE2-B388-8A4267E219EB' { 'Office15_StandardR_Retail' }
        '603EDDF5-E827-4233-AFDE-4084B3F3B30C' { 'Office15_StandardR_Trial' }
        'B13AFB38-CD79-4AE5-9F7F-EED058D750CA' { 'Office Visio Standard 2013 Office Standard 2013' }
        'A24CCA51-3D54-4C41-8A76-4031F5338CB2' { 'Office15_StandardVL_MAK' }
        'E0132983-CA20-4390-8BBA-8FDA37E7C86B' { 'Office15_VisioLPK_Bypass' }
        '4B2E77A0-8321-42A0-B36D-66A2CDB27AF4' { 'Office15_VisioProCO365R_Subscription' }
        '6C44E4BD-C6DB-474A-877E-1BB899ACA206' { 'Office15_VisioProCO365R_SubTest' }
        '79EEBE53-530A-4869-B56B-B4FFE0A1B831' { 'Office15_VisioProCO365R_SubTrial' }
        '6A9BD082-8C07-462C-8D19-18C2CAE0FB02' { 'Office15_VisioProDemoR_BypassTrial180' }
        'A491EFAD-26CE-4ED7-B722-4569BA761D14' { 'Office15_VisioProMSDNR_Retail' }
        'A56A3B37-3A35-4BBB-A036-EEE5F1898EEE' { 'Office15_VisioProO365R_Subscription' }
        '27B162B5-F5D2-40E9-8AF3-D42FF4572BD4' { 'Office15_VisioProO365R_SubTest' }
        '402DFB6D-631E-4A3F-9A5A-BE753BFD84C5' { 'Office15_VisioProO365R_SubTrial' }
        '024EA285-2685-48BC-87EF-79B48CC8C027' { 'Office15_VisioProR_Grace' }
        '141F6878-2591-4231-A476-027432E28B2F' { 'Office15_VisioProR_OEM_Perp' }
        '15D12AD4-622D-4257-976C-5EB3282FB93D' { 'Office15_VisioProR_Retail' }
        'F35E39C1-A41F-47C9-A204-2CA3C4B13548' { 'Office15_VisioProR_Trial' }
        'E13AC10E-75D0-4AFF-A0CD-764982CF541C' { 'Office Visio Pro 2013' }
        '3E4294DD-A765-49BC-8DBD-CF8B62A4BD3D' { 'Office15_VisioProVL_MAK' }
        'C5A7B998-FAE7-4F08-9802-9A2216F1EC2B' { 'Office15_VisioStdCO365R_Subscription' }
        '1B170697-99F8-4B3C-861D-FBDBE5303A8A' { 'Office15_VisioStdCO365R_SubTest' }
        '2F632ABD-D62A-46C8-BF95-70186096F1ED' { 'Office15_VisioStdCO365R_SubTrial' }
        '980F9E3E-F5A8-41C8-8596-61404ADDF677' { 'Office15_VisioStdO365R_Subscription' }
        'CEED49FA-52AD-4C90-B7D4-926ECDFD7F52' { 'Office15_VisioStdO365R_SubTest' }
        '2E5F5521-6EFA-4E29-804D-993C1D1D7406' { 'Office15_VisioStdO365R_SubTrial' }
        'F97246FA-C8CE-4D41-B6F7-AE718E7891C5' { 'Office15_VisioStdR_Grace' }
        'E67ED831-B287-418B-ABC3-D68403A36166' { 'Office15_VisioStdR_OEM_Perp' }
        'DAE597CE-5823-4C77-9580-7268B93A4B23' { 'Office15_VisioStdR_Retail' }
        'AC4EFAF0-F81F-4F61-BDF7-EA32B02AB117' { 'Office15_VisioStdVL_KMS_Client' }
        '44A1F6FF-0876-4EDB-9169-DBB43101EE89' { 'Office15_VisioStdVL_MAK' }
        'F3B8948B-6F0F-4297-B174-FE3E71416BCA' { 'Office15_WacServerLPK_Bypass' }
        'D6B57A0D-AE69-4A3E-B031-1F993EE52EDC' { 'Office15_WCServer_Bypass' }
        '92485559-060B-44A7-9FC4-207C7A9BD39C' { 'Office15_WordR_Grace' }
        '6A817637-8CA1-45D5-A53D-6B97FB8AF382' { 'Office15_WordR_OEM_Perp' }
        '191509F2-6977-456F-AB30-CF0492B1E93A' { 'Office15_WordR_Retail' }
        'AEA37447-9EE8-4EF5-8032-B0C955B6A4F5' { 'Office15_WordR_Trial' }
        'D9F5B1C6-5386-495A-88F9-9AD6B41AC9B3' { 'Office Word 2013' }
        '9CEDEF15-BE37-4FF0-A08A-13A045540641' { 'Office15_WordVL_MAK' }
        '6b766db0-a520-4418-97b7-a0aea118bf48' { 'Win 8 RTM CoreARM OEM:DM' }
        '2cbb1485-df52-4c29-9815-da6998e056e1' { 'Windows Embedded Standard 8 Beta EmbeddedA Retail:TB:Eval' }
        'b012fb7a-5275-4f58-a592-c7b8ca13fea5' { 'Windows Embedded Standard 8 Beta EmbeddedA OEM:DM' }
        '58c1051b-bb3c-4367-9b99-9ef39046aa97' { 'Windows Embedded Standard 8 Beta EmbeddedA OEM:NONSLP' }
        '78ac7410-fd18-4dbd-9982-eb4161a6653a' { 'Win 8 RTM CoreARM OEM:NONSLP' }
        'd41625e4-a75a-44df-8d16-574c95f6d6d3' { 'POSReady 8 Beta EmbeddedIndustry OEM:NONSLP' }
        '34651e08-53a1-4a92-8ec8-30eb8e0f73a5' { 'POSReady 8 Beta EmbeddedIndustry Retail:TB:Eval' }
        'b7787ae7-4bf8-41e4-854d-c8f853d1606f' { 'POSReady 8 Beta EmbeddedIndustry Retail' }
        'c0708dbd-d736-4389-b4d8-27b2f899524a' { 'POSReady 8 Beta EmbeddedIndustryE Retail' }
        '5ca3e488-dbae-4fae-8282-a98fbcd21126' { 'POSReady 8 Beta EmbeddedIndustryE Volume:GVLK' }
        '20f611bc-c50d-4c3a-878e-4338e46141e2' { 'POSReady 8 Beta EmbeddedIndustryE Volume:MAK' }
        '75341c16-374d-4b0b-b248-bec1e0d9e44b' { 'POSReady 8 Beta EmbeddedIndustryE Retail:TB:Eval' }
        'ab1a6590-d3e3-42e7-935b-810a2494a432' { 'Windows Embedded Standard 8 RTM Embedded Retail:TB:Eval' }
        'ab75630e-1c24-4f68-bfca-c374f59ae815' { 'Windows Embedded Standard 8 RTM Embedded Retail:TB:Eval' }
        'ea764f2d-56c4-4d1b-b45f-46e068eb3619' { 'Windows Embedded Standard 8 RTM Embedded Retail:TB:Eval' }
        'fc474b8d-d005-46fc-96f5-f230d5792cd9' { 'Windows Embedded Standard 8 RTM Embedded Retail' }
        'b06bdff0-f320-48eb-97d1-28d5e18c7a34' { 'Windows Embedded Standard 8 RTM APPXLOB-Embedded OEM:NONSLP' }
        'ac3c60d9-5b2f-4fe6-94bc-4060f1f8c3dc' { 'Windows Embedded Standard 8 RTM APPXLOB-Embedded Retail:TB:Eval' }
        '1e58c9d7-e3f1-4f69-9039-1f162463ac2c' { 'Windows Embedded Standard 8 RTM APPXLOB-Embedded Volume:MAK' }
        '4b01cd02-8a33-4887-9f32-f3146ad7fe45' { 'Windows Embedded Standard 8 RTM APPXLOB-Embedded Volume:MAK' }
        '2bd32cda-9fdf-4048-a750-113b14b0eb7e' { 'Windows Embedded Standard 8 RTM APPXLOB-Embedded Volume:MAK' }
        '890c2bc9-b3be-4460-b8ce-d7cf882fab53' { 'Windows Embedded Standard 8 RTM Embedded OEM:NONSLP' }
        '9759968d-6770-4c25-8941-0ceb69eb5fbb' { 'Windows Embedded Standard 8 RTM Embedded OEM:NONSLP' }
        '93cfeb06-05af-4ae8-97ff-c3fd575e5cee' { 'Windows Embedded Standard 8 RTM Embedded OEM:DM' }
        '84171b32-6c39-492c-9e0b-41ad14ff26d8' { 'Windows Embedded Standard 8 RTM Embedded OEM:DM' }
        '331cc226-0a4d-445d-b2f7-d58cb17e5e71' { 'Windows Embedded Standard 8 RTM Embedded Retail' }
        '8f365ba6-c1b9-4223-98fc-282a0756a3ed' { 'Windows Server Essentials 2012 RTM ServerSolution Volume:GVLK' }
        'f5087a06-1ddc-4de3-95b7-8d8a4dbb1b3f' { 'Windows vNext Test ServerStandard VT:IA' }
        '062c594b-8615-41fd-a462-87670482165c' { 'Windows vNext Test ServerDatacenter VT:IA' }
        '93f2ea62-ee1e-4324-886f-57055ad7f674' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry Retail:TB:Eval' }
        '2152e4c0-0681-4b7b-ab57-b24df0c7416c' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry Retail:TB:Eval' }
        'c4fb0b3b-90b4-487b-ae12-64ba1dccf04f' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry Retail:TB:Eval' }
        'd728c961-34d6-45ba-91bb-87a8faf46e44' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry Retail' }
        '73e01f81-b9d8-4a44-8d5a-534229107bfe' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry OEM:NONSLP' }
        'fc7416d9-0cc1-4bcc-b17f-39d2cc192b6a' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry OEM:DM' }
        'b4d532ea-30eb-4c54-b2e3-4fc6cbc048b6' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry OEM:DM' }
        '5463f2ee-278d-4736-9d3f-b9d95a7f1f60' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry OEM:DM' }
        'ffee4506-8519-49f8-9642-f4688250ec08' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry Volume:MAK' }
        '251ef9bf-2005-442f-94c4-86307de7bb32' { 'Windows Embedded Industry 8 RTM APPXLOB-Embedded Volume:MAK' }
        '6c2bb877-b5e2-4812-9b6f-3d6dae62b089' { 'Windows Embedded Industry 8 RTM APPXLOB-Embedded Volume:MAK' }
        '7f70fca8-36c1-4c4f-a9b0-d329697d213f' { 'Windows Embedded Industry 8 RTM APPXLOB-Embedded Volume:MAK' }
        '10018baf-ce21-4060-80bd-47fe74ed4dab' { 'Windows Embedded Industry 8 RTM EmbeddedIndustry Volume:GVLK' }
        '95b3d457-44b1-49f7-a364-fe2768425030' { 'Windows Embedded Industry 8 RTM EmbeddedIndustryE Retail:TB:Eval' }
        '5909e8ba-2f87-4374-994a-642796003e94' { 'Windows Embedded Industry 8 RTM EmbeddedIndustryE Retail:TB:Eval' }
        '88c1be07-44de-41a5-a94d-58de36ca43fc' { 'Windows Embedded Industry 8 RTM EmbeddedIndustryE Retail:TB:Eval' }
        'e815ea0d-7377-4fc0-83bc-d5548c2c7ada' { 'Windows Embedded Industry 8 RTM EmbeddedIndustryE Retail' }
        'f969bfd3-472d-413b-8c94-164c3bff4c0a' { 'Windows Embedded Industry 8 RTM EmbeddedIndustryE Volume:MAK' }
        '70f13f47-e981-4a64-86ba-3f4f60e9abf8' { 'Windows Embedded Industry 8 RTM APPXLOB-Embedded Volume:MAK' }
        '6e53f42e-fe47-48e2-885c-3aec236327ca' { 'Windows Embedded Industry 8 RTM APPXLOB-Embedded Volume:MAK' }
        '6721c983-a7b8-4a81-800d-428e6b7d8a8e' { 'Windows Embedded Industry 8 RTM APPXLOB-Embedded Volume:MAK' }
        '18db1848-12e0-4167-b9d7-da7fcda507db' { 'Windows Embedded Industry 8 RTM EmbeddedIndustryE Volume:GVLK' }
        'd112cbd5-ad2f-4f37-9cb4-bc31c08211e2' { 'ServerCloudStorage Next Beta ServerCloudStorage OEM:SLP' }
        'f270896d-e836-4357-a27d-ba1dbc6f3743' { 'ServerCloudStorage Next Beta ServerCloudStorage OEM:NONSLP' }
        '5F80CD86-1A00-4F1E-BAB1-EA4A5959F380' { 'CRM 6 RTM Enterprise Server Volume:GVLK' }
        'D0B07E3F-9921-4307-AD2C-7B4EAB9E5D61' { 'CRM 6 RTM Enterprise Server Retail' }
        '39575532-5539-43C7-97A8-5124C6D921A0' { 'CRM 6 RTM Online Server Retail' }
        '717F99B8-4C2B-48FF-9B67-9B584FC6F38E' { 'CRM 6 RTM Service Provider Volume:GVLK' }
        '9ACCE7BA-FADC-48E6-A3FB-B8DD772326D4' { 'CRM 6 RTM Workgroup Server Volume:GVLK' }
        'F225B346-050C-4E01-9FA6-856EB78F8BE7' { 'CRM 6 RTM Workgroup Server Retail' }
        'a5660459-eecb-402a-ae58-9256b9214f76' { 'Windows Embedded Industry Next Beta EmbeddedIndustryEval Retail:TB:Eval' }
        'b7610cd6-9f6e-4a6b-9846-1e9f30bc95c2' { 'Windows Embedded Industry Next Beta EmbeddedIndustry OEM:NONSLP' }
        '4451c642-6a57-4b2b-932b-5d94129897ef' { 'Windows Embedded Industry Next Beta EmbeddedIndustry OEM:DM' }
        'c35a9336-fb02-48db-8f4d-245c17f03667' { 'Windows Embedded Industry Next Beta EmbeddedIndustry Volume:GVLK' }
        '68bc2dd6-9a01-477b-ac7f-88b9709af75d' { 'Windows Embedded Industry Next Beta EmbeddedIndustry Volume:MAK' }
        '87c67764-b6e6-4b18-b603-d4fd67012083' { 'Windows Embedded Industry Next Beta EmbeddedIndustryEEval Retail:TB:Eval' }
        '3e548858-b936-48e1-aa61-8a25ba990dab' { 'Windows Embedded Industry Next Beta EmbeddedIndustryE OEM:NONSLP' }
        '4daf1e3e-6be9-4848-8f5a-a18a0d2895e1' { 'Windows Embedded Industry Next Beta EmbeddedIndustryE Volume:GVLK' }
        '56a82112-00ad-4497-9eea-8ac182430dc5' { 'Windows Embedded Industry Next Beta EmbeddedIndustryE Volume:MAK' }
        '329cf0e4-4ade-4391-9f71-e225f53c2ee1' { 'Windows Embedded Industry Next Beta EmbeddedIndustryA OEM:NONSLP' }
        '6c4dba01-6fbf-48ae-9271-70b6a17c4a40' { 'Windows Embedded Industry Next Beta EmbeddedIndustryA OEM:DM' }
        '9cc2564c-292e-4d8a-b9f9-1f5007d9409a' { 'Windows Embedded Industry Next Beta EmbeddedIndustryA Volume:GVLK' }
        '268345e7-ad2a-4e18-ab96-6918863f3c1d' { 'Windows Embedded Industry Next Beta EmbeddedIndustryA Volume:MAK' }
        '4a9eba79-a93c-438c-9930-7922f2bbfd33' { 'Windows Server Next Beta ServerStandard VT:IA' }
        'c9809b5d-c3c4-4d2d-a27e-ec3b273d4307' { 'Windows Server Next Beta ServerDatacenter VT:IA' }
        '1103486e-71e0-4679-9441-1970859a2aa6' { 'Windows Server Next Beta ServerStandard OEM:SLP' }
        'a947b8eb-eb40-4864-97d9-5bd3a9d749f6' { 'Windows Server Next Beta ServerDatacenter OEM:SLP' }
        'a293499e-5c36-4383-a10d-621ed3fed043' { 'Windows Server Essentials Next Beta ServerSolution VT:IA' }
        '439e8c91-ff38-4ecb-ba0b-32658680c952' { 'Windows Server 12 R2 RTM ServerStandard Retail' }
        '4fc45a88-26b5-4cf9-9eef-769ee3f0a016' { 'Windows Server 12 R2 RTM ServerStandardEval Retail:TB:Eval' }
        'c7e5dd52-ef14-4bf6-bc71-1bf5f5794cd0' { 'Windows Server 12 R2 RTM ServerStandard OEM:SLP' }
        'd3081572-e3f0-49f5-8b83-ec763c014570' { 'Windows Server 12 R2 RTM ServerStandard OEM:SLP (MUI locked to zh-CN)' }
        '5b338ef7-8d99-45cb-bb59-618bd328b4a4' { 'Windows Server 12 R2 RTM ServerStandard OEM:NONSLP' }
        'c6b0fae3-70ea-4a98-95f2-587dc1ea4131' { 'Windows Server 12 R2 RTM ServerStandard OEM:NONSLP (MUI locked to zh-CN)' }
        '979d2e65-04b7-44c9-9d7b-ef4028168cba' { 'Windows Server 12 R2 RTM ServerStandard Volume:MAK' }
        'b3ca044e-a358-4d68-9883-aaa2941aca99' { 'Windows Server 2012 R2 Standard' }
        'c2d61e88-5598-4e77-aae2-286dc6670a89' { 'Windows Server 12 R2 RTM ServerDatacenter Retail' }
        'e628c5e8-2300-4429-8b80-a8b21bd7ce0a' { 'Windows Server 12 R2 RTM ServerDatacenterEval Retail:TB:Eval' }
        '66d129b6-eae9-414e-a39a-ea5b8be961cc' { 'Windows Server 12 R2 RTM ServerDatacenter OEM:SLP' }
        'fecbc8f2-a4b1-402a-92e7-5d81a6fe3e80' { 'Windows Server 12 R2 RTM ServerDatacenter OEM:SLP (MUI locked to zh-CN)' }
        '1226e046-263d-414c-824f-0d4f458cee3a' { 'Windows Server 12 R2 RTM ServerDatacenter OEM:NONSLP' }
        '1cc95b8e-1b6e-42cc-9768-9e84ce28cc3f' { 'Windows Server 12 R2 RTM ServerDatacenter OEM:NONSLP (MUI locked to zh-CN)' }
        '641f81b2-63c2-47dd-aba7-c24bf651ff85' { 'Windows Server 12 R2 RTM ServerDatacenter Volume:MAK' }
        '00091344-1ea4-4f37-b789-01750ba6988c' { 'Windows Server 2012 R2 Datacenter' }
        'c77db0a9-53d5-4374-b5fb-474e00a691be' { 'Windows Server 12 R2 RTM ServerWinFoundation OEM:SLP' }
        'a2dc4de1-b9fe-47a2-8717-67a5d4ca2ba4' { 'Windows Server 12 R2 RTM ServerWinFoundation OEM:SLP (MUI locked to zh-CN)' }
        '00b997e2-864d-40b5-b80c-112aaed7bc5b' { 'Windows Server 12 R2 RTM ServerWinFoundation OEM:NONSLP' }
        '398cf8ec-a090-4984-9f90-e7938babdc55' { 'Windows Server 12 R2 RTM ServerWinFoundation OEM:NONSLP (MUI locked to zh-CN)' }
        'bffb487e-c76f-49ff-b006-169d06ef9d67' { 'Windows Server 12 R2 RTM ServerWinFoundation Retail' }
        'f002931d-5536-4908-8d93-40ae584e24d6' { 'Windows Server 12 R2 RTM ServerStandard VT:IA' }
        '640e7014-6f45-4106-bd1d-ac17a812a2d1' { 'Windows Server 12 R2 RTM ServerDatacenter VT:IA' }
        '1f69990a-882c-41d0-bc52-f294badd6a84' { 'ServerCloudStorage 12 R2 RTM ServerCloudStorage Retail' }
        '581e30e6-c16d-4db7-9797-386576439267' { 'ServerCloudStorage 12 R2 RTM ServerCloudStorage OEM:SLP' }
        '8a72972b-7b86-4d8d-a4e4-79da4e916297' { 'ServerCloudStorage 12 R2 RTM ServerCloudStorage OEM:NONSLP' }
        'b743a2be-68d4-4dd3-af32-92425b7bb623' { 'Windows Server 2012 R2 Cloud Storage' }
        'e7cb1f59-5bff-42e2-831e-f2b9a44c3961' { 'Storage Server 2012 R2 RTM ServerStorageStandard OEM:SLP' }
        '3b1fa934-29ab-4ae2-bf6e-ccbaef7f3031' { 'Storage Server 2012 R2 RTM ServerStorageStandard OEM:NONSLP' }
        '7ec7a624-e060-445c-b52b-2621e69e016b' { 'Storage Server 2012 R2 RTM ServerStorageStandard Retail' }
        'b9f3109c-bfa9-4f37-9824-6dba9ee62056' { 'Storage Server 2012 R2 RTM ServerStorageStandardEval Retail:TB:Eval' }
        '2d3b7269-65f4-467d-9d51-dbe0e5a4e668' { 'Storage Server 2012 R2 RTM ServerStorageWorkgroupEval Retail:TB:Eval' }
        '6f35b08e-e4ca-4c87-834e-6a59e64b9d0d' { 'Storage Server 2012 R2 RTM ServerStorageWorkgroup OEM:SLP' }
        '667cf149-d9e5-40bf-8047-53bd15bcdb0a' { 'Storage Server 2012 R2 RTM ServerStorageWorkgroup OEM:NONSLP' }
        '20ea7d3b-99c1-4d42-994f-a103fdac65d5' { 'Storage Server 2012 R2 RTM ServerStorageWorkgroup Retail' }
        '2994120e-2119-47df-b779-076c79acc297' { 'Windows Server Essentials 2012 R2 RTM ServerSolution OEM:SLP' }
        '64ae227f-0baf-4f75-ab38-79887da96115' { 'Windows Server Essentials 2012 R2 RTM ServerSolution OEM:SLP (MUI locked to zh-CN)' }
        'e96022a1-3247-4125-9ddc-4c6068ab3bfc' { 'Windows Server Essentials 2012 R2 RTM ServerSolution OEM:NONSLP' }
        '866e0a28-d082-41fb-b584-411e2ff09b90' { 'Windows Server Essentials 2012 R2 RTM ServerSolution OEM:NONSLP (MUI locked to zh-CN)' }
        '9986e719-0599-4daa-b72e-ac8e505031db' { 'Windows Server Essentials 2012 R2 RTM ServerSolution Retail' }
        '0c02eb79-fa61-43e0-9b8b-c6584c85caf8' { 'Windows Server Essentials 2012 R2 RTM ServerSolution Volume:MAK' }
        '21db6ba4-9a7b-4a14-9e29-64a60c59301d' { 'Windows Server Essentials 2012 R2' }
        '2528222c-11e5-4238-ac71-e187f964c787' { 'Windows Server Essentials 2012 R2 RTM ServerSolution VT:IA' }
        'c7c00280-b24d-4e82-89ca-4f1288eb1d9e' { 'Win 8.1 RTM Core OEM:DM' }
        '51b43152-a885-432f-a1cb-a575ca416784' { 'Win 8.1 RTM Professional OEM:DM' }
        '24c2ee7a-4a61-448d-a8b0-a1a08edfd867' { 'Win 8.1 RTM ProfessionalN OEM:DM' }
        'b080aea2-e6c5-4b22-838e-fa4a21c931e3' { 'Win 8.1 RTM Core OEM:NONSLP' }
        '78d9b031-b92d-4fc7-b6df-38b42dcc7110' { 'Win 8.1 RTM CoreARM OEM:NONSLP' }
        'b8490a14-d942-43bb-a1b5-68f347757bce' { 'Win 8.1 RTM CoreCountrySpecific OEM:NONSLP' }
        'b656184e-5c4d-47e9-9797-0959c94a9404' { 'Win 8.1 RTM CoreN OEM:NONSLP' }
        'bea5bfff-b61d-45e5-bc61-4fca1d85b501' { 'Win 8.1 RTM CoreSingleLanguage OEM:NONSLP' }
        'd03e843c-9044-4cd4-b5eb-78a9586b5598' { 'Win 8.1 RTM Professional OEM:NONSLP' }
        '8b547029-1c12-405d-9df7-8faa53949a3f' { 'Win 8.1 RTM ProfessionalN OEM:NONSLP' }
        '9a8645c4-8908-49bb-8eec-6671a533b17a' { 'Win 8.1 RTM Core Retail' }
        '9e263fcf-ef40-428c-8aa1-40e09e2994db' { 'Win 8.1 RTM Core OEM:DM' }
        'c4b15b02-3fe9-4ac0-878e-a4b10ffe84bf' { 'Win 8.1 RTM CoreN Retail' }
        '8da2dfae-e4f5-4e6a-9272-96f8470e033e' { 'Win 8.1 RTM Professional Retail' }
        '92bd040f-0108-45dd-94e3-e0d6423df214' { 'Win 8.1 RTM ProfessionalN Retail' }
        '4fea9ede-e6ee-41a6-a231-1604ec75c480' { 'Win 8.1 RTM ProfessionalN Retail' }
        '8d904b5c-2cd4-43f4-846a-f0f5d60387a0' { 'Win 8.1 RTM ProfessionalWMC Retail' }
        '513b06ef-c15f-4df0-9097-a4768323bfb6' { 'Win 8.1 RTM ProfessionalWMC Retail' }
        '7fd0a88b-fb89-415f-9b79-84adc6a7cd56' { 'Win 8.1 RTM EnterpriseNEval Retail:TB:Eval' }
        '0eebbb45-29d4-49cb-ba87-a23db0cce40a' { 'Win 8.1 RTM EnterpriseEval Retail:TB:Eval' }
        'fe1c3238-432a-43a1-8e25-97e7d1ef10f3' { 'Windows 8.1 Core' }
        'c4804ecf-6db4-4134-90a9-90d0874c9ad8' { 'Win 8.1 RTM CoreARM OEM:DM' }
        'ffee456a-cd87-4390-8e07-16146c672fd0' { 'Win 8.1 RTM CoreARM Volume:GVLK' }
        'db78b74f-ef1c-4892-abfe-1e66b8231df6' { 'Win 8.1 RTM CoreCountrySpecific Volume:GVLK' }
        '78558a64-dc19-43fe-a0d0-8075b2a370a3' { 'Windows 8.1 CoreN' }
        'c72c6a1d-f252-4e7e-bdd1-3fca342acb35' { 'Win 8.1 RTM CoreSingleLanguage Volume:GVLK' }
        '81671aaf-79d1-4eb1-b004-8cbbe173afea' { 'Windows 8.1 Enterprise' }
        '113e705c-fa49-48a4-beea-7dd879b46b14' { 'Windows 8.1 EnterpriseN' }
        'c06b6981-d7fd-4a35-b7b4-054742b7af67' { 'Windows 8.1 Professional' }
        '7476d79f-8e48-49b4-ab63-4d0b813a16e4' { 'Windows 8.1 ProfessionalN' }
        '096ce63d-4fac-48a9-82a9-61ae9e800e5f' { 'Windows 8.1 Professional WMC' }
        '354d964a-56e7-43c5-a93f-287a7a750bd4' { 'Win 8.1 RTM Professional;ProfessionalN Volume:MAK' }
        '4bbc5a14-ec8c-4954-a8f3-1dad8c225d37' { 'Win 8.1 RTM CoreARM OEM:DM' }
        'fd9e2767-c9dc-4ba9-a70a-e690649d7301' { 'Win 8.1 RTM ProfessionalWMC Retail' }
        'cdcc4295-9acc-4fd9-a2b6-ade31f228d73' { 'Win 8.1 RTM CoreCountrySpecific OEM:DM' }
        'a143fcf7-82ba-4829-b005-063a5fb76e82' { 'Win 8.1 RTM CoreN OEM:DM' }
        'e2ca509a-a2f4-498b-ba09-297685d369ac' { 'Win 8.1 RTM CoreSingleLanguage OEM:DM' }
        '12788d53-9337-42dc-88c9-413b553ba71c' { 'Win 8.1 RTM CoreSingleLanguage OEM:DM' }
        '763fe1c2-d40f-4f3c-9a28-7a3af6f0d987' { 'Win 8.1 RTM Professional OEM:DM' }
        'f1a8fe3c-5d21-4050-9cb9-695449b058e4' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryEval Retail:TB:Eval' }
        'd9eea459-1e6b-499d-8486-e68163f2a8be' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryEval Retail:TB:Eval' }
        '0553d524-1466-4fdc-8bab-a6482da45008' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryEval Retail:TB:Eval' }
        'e7c5a5e6-f494-4a14-8e19-2c4086518afa' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry Retail' }
        'c30808ff-8237-4ef2-b4c3-74720694d90d' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry OEM:NONSLP' }
        '7d185910-7676-4b20-9d7d-2c7ffa3880cc' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry OEM:NONSLP' }
        'b76ff67a-190e-487d-8b41-daaaebed17f1' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry OEM:NONSLP' }
        '28fb4ea8-9b40-4358-93d5-e0dd952a69a4' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry OEM:NONSLP' }
        '7a1091b7-d6a0-48ac-80d7-edf9288386ed' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry OEM:DM' }
        '67a4011a-90f1-42f4-8b79-709e0ef5c7c0' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry OEM:DM' }
        '2cc1bcf9-c562-4008-93ee-bdc6d7e879e8' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry OEM:DM' }
        '8607e7a6-552c-4b4d-8de0-a07ce766c9b1' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry OEM:DM' }
        'da7c8412-76da-4f77-813b-ee6c57683812' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry OEM:DM' }
        '1ec32ff8-292f-4e5a-b0b4-d50a45fa4543' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustry Volume:MAK' }
        '0ab82d54-47f4-4acb-818c-cc5bf0ecb649' { 'Windows Embedded Industry 8.1' }
        '1d44bb28-1e92-4307-ba6e-8704175429dd' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryEEval Retail:TB:Eval' }
        'c4b908d2-c4b9-439d-8ff0-48b656a24da4' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryEEval Retail:TB:Eval' }
        '547b4ccc-3d68-4864-81ea-a0df667b1e01' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryEEval Retail:TB:Eval' }
        'eb9c6ae3-e55d-4c4e-bd7d-997974cda6d2' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryE Retail' }
        'c8eaea63-78c9-4018-a8be-176e0e21efc3' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryE Volume:MAK' }
        'cd4e2d9f-5059-4a50-a92d-05d5bb1267c7' { 'Windows Embedded IndustryE 8.1' }
        'a617c12c-d07e-486a-95cc-6116f9cef6f4' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryA OEM:NONSLP' }
        '0dfc43bc-f8b6-4332-8803-1ab525f00f26' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryA OEM:DM' }
        '72b48e55-6168-4e87-a83e-5d38a5770ae3' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryA OEM:DM' }
        '0dfb75d0-bc18-4889-9cfa-d73417d51cbe' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryA OEM:DM' }
        '822ddf91-4e9a-449d-9cea-360573738d2e' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryA OEM:DM' }
        '0c4788b6-7e05-464b-abab-b026e585e1cc' { 'Windows Embedded Industry 8.1 RTM EmbeddedIndustryA Volume:MAK' }
        'f7e88590-dfc7-4c78-bccb-6f3865b99d1a' { 'Windows Embedded IndustryA 8.1' }
        '7e60069d-ea09-40fb-a50b-cd9cb82174c1' { 'Windows Server Essentials 2012 R2 RTM ServerSolution Retail:TB:Eval' }
        '3D0631E3-1091-416D-92A5-42F84A86D868' { 'Office16_O365BusinessR_Grace' }
        '6337137E-7C07-4197-8986-BECE6A76FC33' { 'Office16_O365BusinessR_Subscription' }
        '812837CB-040B-4829-8E22-15C4919FEBA4' { 'Office16_O365BusinessR_SubTrial' }
        '742178ED-6B28-42DD-B3D7-B7C0EA78741B' { 'Office16_O365BusinessR_SubTest' }
        '34EBB57F-0773-4DF5-8EBD-BF55D194DC69' { 'Office16_PersonalPipcR_Grace' }
        '5AAB8561-1686-43F7-9FF5-2C861DA58D17' { 'Office16_PersonalPipcR_OEM_Perp' }
        'D95CFA27-EDDF-4116-8D28-BBDB1E07B0A5' { 'Office16_HomeBusinessPipcR_Grace' }
        'C02FB62E-1CD5-4E18-BA25-E0480467FFAA' { 'Office16_HomeBusinessPipcR_OEM_Perp' }
        '2A3D3010-CDAB-4F07-8BF2-0E3639BC6B98' { 'Office16_ProfessionalPipcR_Grace' }
        '4E26CAC1-E15A-4467-9069-CB47B67FE191' { 'Office16_ProfessionalPipcR_OEM_Perp' }
        '0ef706a5-beb3-4d84-8ce4-3eb867681947' { 'Win 8.1 RTM CoreConnected OEM:DM' }
        'af6e4b59-36d6-4655-9cf9-2d4da32462a0' { 'Win 8.1 RTM CoreConnected OEM:DM' }
        '54d2e94d-b1a8-40e9-aad4-90d714fd0397' { 'Win 8.1 RTM CoreConnected OEM:NONSLP' }
        'f75f855d-c551-4372-8e10-d7601014b8d1' { 'Win 8.1 RTM CoreConnected Retail' }
        'e9942b32-2e55-4197-b0bd-5ff58cba8860' { 'Win 8.1 RTM CoreConnected Volume:GVLK' }
        'ed3159f0-d461-4bb6-b497-e39dc60bc6b7' { 'Win 8.1 RTM CoreConnectedN OEM:DM' }
        'a220e795-38d4-4f67-ad33-adf7c551da69' { 'Win 8.1 RTM CoreConnectedN OEM:NONSLP' }
        '846471a2-2ca8-420e-a086-1f6b7f7600f6' { 'Win 8.1 RTM CoreConnectedN Retail' }
        'c6ddecd6-2354-4c19-909b-306a3058484e' { 'Win 8.1 RTM CoreConnectedN Volume:GVLK' }
        'd3347d1a-f759-4c2c-b807-216a91405835' { 'Win 8.1 RTM ProfessionalStudent OEM:DM' }
        'e27459f7-7e70-4d3a-ae93-224a2515e419' { 'Win 8.1 RTM ProfessionalStudent OEM:DM' }
        'f862e93a-1f3d-4e21-8723-bbee862487e9' { 'Win 8.1 RTM ProfessionalStudent OEM:NONSLP' }
        'e25b7ed5-7a46-466b-acc1-6a410ee55478' { 'Win 8.1 RTM ProfessionalStudent Retail' }
        'e58d87b5-8126-4580-80fb-861b22f79296' { 'Win 8.1 RTM ProfessionalStudent Volume:GVLK' }
        '809a6525-264d-4cc9-8fb2-88df2aab0f80' { 'Win 8.1 RTM ProfessionalStudentN OEM:DM' }
        'effed9b4-3f0a-40be-af85-6eec66d29bd6' { 'Win 8.1 RTM ProfessionalStudentN OEM:NONSLP' }
        '640a26b0-6f32-4e2f-b47a-d6c51c8e7e5d' { 'Win 8.1 RTM ProfessionalStudentN Retail' }
        'cab491c7-a918-4f60-b502-dab75e334f40' { 'Win 8.1 RTM ProfessionalStudentN Volume:GVLK' }
        '50e701fc-1c15-4e26-a244-87d5248c3d3d' { 'Win 8.1 RTM CoreConnectedSingleLanguage OEM:DM' }
        '1cb1d5c8-555f-4faf-935d-1477b904b6e4' { 'Win 8.1 RTM CoreConnectedSingleLanguage OEM:DM' }
        '355c6932-54b6-423f-b76f-6b8ed6d6a5e3' { 'Win 8.1 RTM CoreConnectedSingleLanguage OEM:NONSLP' }
        'b8f5e3a3-ed33-4608-81e1-37d6c9dcfd9c' { 'Win 8.1 RTM CoreConnectedSingleLanguage Volume:GVLK' }
        'e905f108-1c8f-4058-ae1b-8e18372aaa64' { 'Win 8.1 RTM CoreConnectedCountrySpecific OEM:DM' }
        'c8ad0cb2-b2cb-4c03-acf2-0231fdce675f' { 'Win 8.1 RTM CoreConnectedCountrySpecific OEM:NONSLP' }
        'ba998212-460a-44db-bfb5-71bf09d1c68b' { 'Win 8.1 RTM CoreConnectedCountrySpecific Volume:GVLK' }
        '45D0201C-7909-4A4C-9E98-10DA612BE594' { 'Visual Studio Dev14 Beta Dev12 Beta Key Retail' }
        '0DA0C954-144B-4FB1-B9F4-215C5E84C6C8' { 'Visual Studio Dev14 Beta Isolated Shell Retail' }
        'D1E44AEE-AF7C-48D1-ABE0-F5A11EA65F79' { 'Visual Studio Dev14 Beta Isolated Shell Retail' }
        'C8D31253-520F-4F53-B005-B0E1C4E32314' { 'Visual Studio Dev14 Beta Integrated Shell Retail' }
        '0253BFFC-AFFF-4741-910D-6D61DC5A4FE3' { 'Visual Studio Dev14 Beta Integrated Shell Retail' }
        '9FCE6EE4-E187-4F47-9032-B8EEC164DA82' { 'Visual Studio Dev14 Beta Express for Windows Retail' }
        'F1EE2E82-7535-402C-8867-CD7E50EEE22E' { 'Visual Studio Dev14 Beta Express for Windows Retail' }
        '4C8D350E-32FC-400E-BE10-122DE99329C0' { 'Visual Studio Dev14 Beta Express for Windows Retail' }
        '5CD354F9-F604-48E0-BCD5-7E6FED93D0FB' { 'Visual Studio Dev14 Beta Express for Windows Retail' }
        'E882632D-CA01-4F24-B216-3CDAEA562E9F' { 'Visual Studio Dev14 Beta Express for Web Retail' }
        'F72DBE7C-EEFE-4628-A101-558A19ABB941' { 'Visual Studio Dev14 Beta Express for Web Retail' }
        'EF600219-3149-4F1D-B4A6-A64366DB7686' { 'Visual Studio Dev14 Beta Express for Web Retail' }
        '8C0AFE01-44C9-4FCF-A633-6F69811E94F3' { 'Visual Studio Dev14 Beta Express for Web Retail' }
        'D50F0BF4-09FB-49CE-90A4-49CFE2E418DE' { 'Visual Studio Dev14 Beta Express for Desktop Retail' }
        'C1241BBE-6C38-4441-9B9E-EACA7BDDE1CD' { 'Visual Studio Dev14 Beta Express for Desktop Retail' }
        '730E1394-0A8E-4AF5-8305-9082B18A599F' { 'Visual Studio Dev14 Beta Express for Desktop Retail' }
        '88333C2C-23E5-4703-A14A-04BB4A912E63' { 'Visual Studio Dev14 Beta Express for Desktop Retail' }
        '2DABA9A7-E51F-49E6-8C81-B13806E5F14A' { 'Visual Studio Dev14 Beta Professional Retail' }
        '76917F6A-B5B9-4F91-8CDB-9AE961EB8105' { 'Visual Studio Dev14 Beta Professional Retail' }
        '2F428575-7A4B-48F4-A092-0D1963B7F31F' { 'Visual Studio Dev14 Beta Professional Retail' }
        '2D01133D-1A8C-4CCE-9331-7549A77CDC33' { 'Visual Studio Dev14 Beta Professional Retail' }
        '63B3CA53-A9E8-484C-890E-88DCCEFE3510' { 'Visual Studio Dev14 Beta Professional Retail' }
        '1EBC5CF0-D92C-489D-9010-B9D988FFC6F5' { 'Visual Studio Dev14 Beta Professional Retail' }
        '4864F0BA-A6AF-4E05-8149-1B4D88B6BEE8' { 'Visual Studio Dev14 Beta Professional Retail' }
        '12AB0C83-F04B-473A-8CF3-370058CA9FCF' { 'Visual Studio Dev14 Beta Professional Volume:GVLK' }
        '6A307303-B737-4FCD-92FF-D65B2E2CB237' { 'Visual Studio Dev14 Beta Professional Retail' }
        'D11696F4-57CD-46E6-AB22-77B2617C8CBB' { 'Visual Studio Dev14 Beta Ultimate Retail' }
        '85D2BA53-874B-44A9-9266-CF5E39C7503B' { 'Visual Studio Dev14 Beta Ultimate Retail' }
        'CA38F2AE-080C-4026-9BA3-6BBE6B416D44' { 'Visual Studio Dev14 Beta Ultimate Retail' }
        'A7E58F1D-9A02-4D6A-AEBF-92B91165D3DA' { 'Visual Studio Dev14 Beta Ultimate Retail' }
        '26322AC3-0A49-4D49-BADD-B89DC736B4DE' { 'Visual Studio Dev14 Beta Ultimate Volume:GVLK' }
        '1202E6A8-575A-4DDA-A501-4D73298DCC94' { 'Visual Studio Dev14 Beta Ultimate Retail' }
        '8A2DA7F9-AADB-4545-8197-4108EFED44D9' { 'Visual Studio Dev14 Beta Release Managment Retail' }
        '51ED361A-1CF4-45D3-A53D-A8AB85C0324F' { 'Visual Studio Dev14 Beta Release Managment Retail' }
        'F5248137-4388-4BC8-9D11-7DC1EB9EBE42' { 'Visual Studio Dev14 Beta Release Managment Retail' }
        '1B0F060C-6286-455C-B452-038F334A48C2' { 'Visual Studio Dev14 Beta Release Management Retail' }
        '9C003C0B-1463-4721-956F-585A471024CC' { 'Visual Studio Dev14 Beta Release Managment Volume:GVLK' }
        'FFEBAAA3-8B6F-44F6-90A1-32D23FB7E8D5' { 'Visual Studio Dev14 Beta Release Managment Retail' }
        'A418D092-E06D-4DA2-A0E7-6807F505F593' { 'Visual Studio Dev14 Beta Premium Retail' }
        'A8209C8C-5797-464D-9141-1A26655A3668' { 'Visual Studio Dev14 Beta Premium Retail' }
        'FB835D84-BFF6-48C0-A45F-FB0326A2C6D1' { 'Visual Studio Dev14 Beta Premium Retail' }
        '9F70A3B7-829B-4830-8C0F-9ED039BCEC2D' { 'Visual Studio Dev14 Beta Premium Retail' }
        '111754D2-8231-475F-8061-56ED68BD3B0C' { 'Visual Studio Dev14 Beta Premium Volume:GVLK' }
        'A658E985-0D5B-4505-A4B2-E01DD350EB3E' { 'Visual Studio Dev14 Beta Premium Retail' }
        '16E7FB8D-7DDF-479C-8318-C57C5030AE1F' { 'Visual Studio Dev14 Beta Test Professional Retail' }
        '43FF4414-9B88-4536-8AAA-651335F26DF6' { 'Visual Studio Dev14 Beta Test Professional Retail' }
        '10751A8D-3142-40CB-837A-6EED15F627F4' { 'Visual Studio Dev14 Beta Test Professional Retail' }
        'F3874619-D243-405D-A02A-0529706CDB1C' { 'Visual Studio Dev14 Beta Test Professional Retail' }
        'EC3AB354-9AE5-4ACB-90F5-C007B51DA14E' { 'Visual Studio Dev14 Beta Test Professional Volume:GVLK' }
        'EB36B456-E32B-4C9A-AB6D-96E29624453F' { 'Visual Studio Dev14 Beta Test Professional Retail' }
        '1F2DF869-2C0D-4D9D-AC21-46E721C14B73' { 'Visual Studio Dev14 Beta Team Explorer Everywhere Retail' }
        'DD1F111A-64FE-4D2A-A02B-A175DA52C48D' { 'Visual Studio Dev14 Beta Team Explorer Everywhere Retail' }
        '21F5C69B-C0DD-4241-953C-BC7163AFB545' { 'Visual Studio Dev14 Beta Team Foundation Server Retail' }
        '8AEA1937-83F2-49EC-B50F-F900BFD718E8' { 'Visual Studio Dev14 Beta Team Foundation Server Retail' }
        'B434D8A6-DC32-4957-A449-CD51612D5A55' { 'Visual Studio Dev14 Beta Team Foundation Server Retail' }
        '57AD27F0-5983-4FDC-AB16-E56536C8381D' { 'Visual Studio Dev14 Beta Team Foundation Server Volume:GVLK' }
        'F30807B3-E7A3-49BF-BA60-FA8E02701F0E' { 'Visual Studio Dev14 Beta Team Foundation Server Retail' }
        '3741E507-A237-454A-B5D2-CD884E1BEA47' { 'Visual Studio Dev14 Beta Team Foundation Server Retail' }
        '262F93DF-CFD1-48A4-9856-7FE76E3B7E9C' { 'Visual Studio Dev14 Beta Team Foundation Server Express Retail' }
        '89E6EBC1-12FE-43E3-BBCC-534F450D3BF0' { 'Visual Studio Dev14 Beta Team Foundation Server Express Retail' }
        'C5254393-BD7D-4A98-9765-AFD5FFB8C046' { 'Visual Studio Dev14 Beta Team Foundation Server Express Retail' }
        '4B1B82FC-986F-4C3D-8881-6D9D583D76DF' { 'Visual Studio Dev14 Beta Team Foundation Server Express Retail' }
        '143917A0-3097-4AAA-B70C-5F040823AAC1' { 'Visual Studio Dev14 Beta Visual Studio Agents Retail' }
        'B3F3009C-89FA-4C60-AFBB-A72DB2C2E028' { 'Visual Studio Dev14 Beta Test Agent Retail' }
        '210CECF7-C0D7-40EB-B71D-88B173D4B8F8' { 'Visual Studio Dev14 Beta Test Controller Retail' }
        '758C1797-62FC-4BF1-B717-0EE0FD50027A' { 'Visual Studio Dev14 Beta TBD1 Retail' }
        '14947388-CB98-4480-B898-E305481DCE5B' { 'Visual Studio Dev14 Beta TBD1 Retail' }
        '634180CA-04EA-47CB-A299-4AB211EB15D9' { 'Visual Studio Dev14 Beta TBD1 Retail' }
        '09E69D67-663C-4CD4-B524-0D2EBD27D8E6' { 'Visual Studio Dev14 Beta TBD1 Retail' }
        'DBCC9790-F390-401F-AE75-C1A0D6612329' { 'Visual Studio Dev14 Beta TBD1 Volume:GVLK' }
        '563BCDEC-FAA4-48D4-9831-EA760391BC1D' { 'Visual Studio Dev14 Beta TBD1 Retail' }
        '743D518E-451E-43B3-9FEA-AE6209AB6043' { 'Visual Studio Dev14 Beta TBD2 Retail' }
        '4ECCB496-251F-4C54-91A1-7FDEDB15DF2A' { 'Visual Studio Dev14 Beta TBD2 Retail' }
        '10683DE1-077A-4D65-8E51-9FB4BDB0BB8B' { 'Visual Studio Dev14 Beta TBD2 Retail' }
        'DDE4B476-AEAB-4C8A-ADEF-AE4D7DDD14CF' { 'Visual Studio Dev14 Beta TBD2 Retail' }
        '9ACF5243-A681-4D47-868C-83EA95DA85AC' { 'Visual Studio Dev14 Beta TBD2 Volume:GVLK' }
        '367A97B7-2C0C-4D87-8754-C569E838A743' { 'Visual Studio Dev14 Beta TBD2 Retail' }
        '0BC1BDAE-12D5-4802-AAA7-7246C7796D51' { 'Visual Studio Dev14 Beta TBD3 Retail' }
        '95B8F01D-7819-4D1E-818C-9113B21AC4A5' { 'Visual Studio Dev14 Beta TBD3 Retail' }
        'F5DDA4FE-0EDE-41D4-90EC-900EE86610E3' { 'Visual Studio Dev14 Beta TBD3 Retail' }
        '5558B4DB-2F02-40B8-A062-99A0621709B3' { 'Visual Studio Dev14 Beta TBD3 Retail' }
        '07492C6F-8CC9-44C3-88DD-D286DD1ED73E' { 'Visual Studio Dev14 Beta TBD3 Volume:GVLK' }
        '8794CB78-5179-4BB6-BEFB-BC318B51EBC9' { 'Visual Studio Dev14 Beta TBD3 Retail' }
        'BCC22988-785C-46B4-9739-37AE2F2EE63B' { 'Visual Studio Dev14 Beta Professional Retail' }
        'A234E34C-3C7D-4526-B410-A0FDDB1D6186' { 'Visual Studio Dev14 Beta Ultimate Retail' }
        '572C5BE1-7880-44E8-AEC0-4A167715A790' { 'Visual Studio Dev14 Beta Premium Retail' }
        '7E11F8AC-E53F-4B35-B865-E5A49447FD79' { 'Visual Studio Dev14 Beta Test Professional Retail' }
        '02cf4198-971e-437c-af68-f9cd282acbb5' { 'Win Next Pre-Release CoreConnected OEM:DM' }
        '92bccf8a-fbb8-4e18-b65b-84bfe440dec6' { 'Win Next Pre-Release CoreConnected OEM:NONSLP' }
        '3e0b1557-1849-4a5a-9596-fe05807567cd' { 'Win Next Pre-Release CoreConnected Retail' }
        'c436def1-0dcc-4849-9a59-8b6142eb70f3' { 'Win Next Pre-Release CoreConnected Volume:GVLK' }
        'dfc7df02-69d0-4ca2-9315-eff7a1b33e0f' { 'Win Next Pre-Release CoreConnected Volume:MAK' }
        'a91638e8-02f1-48c1-a02a-b6de5c5ba3e4' { 'Win Next Pre-Release CoreConnectedCountrySpecific OEM:DM' }
        '0294a441-43d5-418f-a26e-5246866af64a' { 'Win Next Pre-Release CoreConnectedCountrySpecific OEM:NONSLP' }
        '1f2b8659-66ab-43fa-b5bf-9294b22bcf76' { 'Win Next Pre-Release CoreConnectedCountrySpecific Retail' }
        'a8651bfb-7fe0-40df-b156-87337ecd5acc' { 'Win Next Pre-Release CoreConnectedCountrySpecific Volume:GVLK' }
        '2e3927d7-d32a-4a70-b0d6-e5836843fd58' { 'Win Next Pre-Release CoreConnectedCountrySpecific Volume:MAK' }
        'ecb5d233-e17f-43ef-938a-c1e762ea0734' { 'Win Next Pre-Release CoreConnectedN OEM:DM' }
        '758a5133-5df6-4675-847c-6c635f58ae65' { 'Win Next Pre-Release CoreConnectedN OEM:NONSLP' }
        'bbd73b43-e84b-4d92-9a8d-1faccfd1381a' { 'Win Next Pre-Release CoreConnectedN Retail' }
        '86f72c8d-8363-4188-b574-1a53cb374711' { 'Win Next Pre-Release CoreConnectedN Volume:GVLK' }
        '1980dee1-d4f8-4bd8-a4ff-2137fa273db2' { 'Win Next Pre-Release CoreConnectedN Volume:MAK' }
        '178f8353-aeff-4ee6-bcbb-f0df876b6b38' { 'Win Next Pre-Release CoreConnectedSingleLanguage OEM:DM' }
        'd0b812fa-5260-4a67-82be-26b1e6f4109a' { 'Win Next Pre-Release CoreConnectedSingleLanguage OEM:NONSLP' }
        '08f92e9f-b42d-4767-88e8-472273d19063' { 'Win Next Pre-Release CoreConnectedSingleLanguage Retail' }
        '5b120df4-ea3f-4e82-b0c0-6568f719730e' { 'Win Next Pre-Release CoreConnectedSingleLanguage Volume:GVLK' }
        'a48e76ac-66fb-436d-b9d4-914d0170f1b3' { 'Win Next Pre-Release CoreConnectedSingleLanguage Volume:MAK' }
        '2e81fa2b-aae3-4600-89dc-8c2f00c2c89f' { 'Win Next Pre-Release ProfessionalStudent OEM:DM' }
        '4e25bbb6-7fd1-482e-9d13-ee48dea1432d' { 'Win Next Pre-Release ProfessionalStudent OEM:NONSLP' }
        '58464d21-6071-4cbe-a08b-6d3ab49ac944' { 'Win Next Pre-Release ProfessionalStudent Retail' }
        'fd5ae385-f5cf-4b53-b1fa-1af6fff7c0d8' { 'Win Next Pre-Release ProfessionalStudent Volume:GVLK' }
        '84bfa0b2-83bd-4e77-99c0-38366858de00' { 'Win Next Pre-Release ProfessionalStudent Volume:MAK' }
        '7aa89b5a-2733-44b5-acba-bae8ac3f61e9' { 'Win Next Pre-Release ProfessionalStudentN OEM:DM' }
        '4963f087-33ba-444f-9b84-9f9a38b6b8b8' { 'Win Next Pre-Release ProfessionalStudentN OEM:NONSLP' }
        'fba80ee0-a92f-43fa-999e-cb594b744061' { 'Win Next Pre-Release ProfessionalStudentN Retail' }
        '687f6358-6a21-453a-a712-3b3b57123827' { 'Win Next Pre-Release ProfessionalStudentN Volume:GVLK' }
        '00eda1a1-e142-42c4-a4ca-41cd848f99fe' { 'Win Next Pre-Release ProfessionalStudentN Volume:MAK' }
        'D545CCF1-CF46-41D0-8D55-D3E8B03CDB64' { 'Office16_PersonalPipcR_PIN' }
        'E260D7A1-49DC-41EE-B275-33A544C96904' { 'Office16_HomeBusinessPipcR_PIN' }
        '70A633E5-AB58-487A-B077-E410B30C5EA4' { 'Office16_ProfessionalPipcR_PIN' }
        '9103F3CE-1084-447A-827E-D6097F68C895' { 'Office16_SkypeServiceBypassR_PrepidBypass' }
        '1E857417-7DA8-4A2D-ABB5-D8060515C8E4' { 'CRM 7 RTM Enterprise Server Volume:GVLK' }
        '8A427315-7274-4977-9F09-DF1EA5B001EF' { 'CRM 7 RTM Enterprise Server Retail' }
        'C3FF6065-9E29-441A-B0CA-C151A10100AE' { 'CRM 7 RTM Online Server Retail' }
        'E6807054-2ABB-4752-81FA-B4292CD97647' { 'CRM 7 RTM Service Provider Volume:GVLK' }
        '8BB8C11D-6739-4B95-ADBA-3710F2446692' { 'CRM 7 RTM Workgroup Server Volume:GVLK' }
        '57A24377-043D-48F6-8273-C104C8CF8F61' { 'CRM 7 RTM Workgroup Server Retail' }
        '6d019696-bbb9-42cf-a2dd-1ac564a3cdb9' { 'Win Next Pre-Release Professional Volume:MAK' }
        '4b69b622-1167-4c2a-a840-62c481591681' { 'Win Next Pre-Release ProfessionalN Volume:MAK' }
        'c94de323-5cee-44b5-993f-744bb6d62d9d' { 'Win Next Pre-Release Enterprise Volume:MAK' }
        '43c55bd5-fae3-42ca-b585-a665abfcb1ca' { 'Win Next Pre-Release EnterpriseN Volume:MAK' }
        'A46815E5-C7E6-4F4F-8994-65BD19DC831D' { 'Office16_O365HomePremR_PIN21' }
        'D059DF6E-43A4-40EE-894D-5186F85AF9A0' { 'Office16_O365HomePremR_PIN22' }
        'E47D40AD-D9D0-4AB0-9C3D-B209E77E7AE8' { 'Office16_O365HomePremR_PIN23' }
        '55671CEE-5384-454B-9160-975BD5441C4B' { 'Office16_HomeBusinessR_PIN' }
        '12367CA7-3B7D-44FD-8765-02469CA5004E' { 'Office16_ProfessionalR_PIN' }
        '253CD5CD-F190-4A8C-80AC-0144DF8990F4' { 'Office16_HomeStudentR_PIN' }
        '58DB55C7-BB77-4C4D-A170-D7ED18A4AECE' { 'Office16_O365HomePremR_PIN24' }
        'B58FB371-5E42-46CE-927B-1A27AE89194C' { 'Office16_O365HomePremR_PIN25' }
        'D84CB3EA-CB53-466A-85C8-E8ED69D3F394' { 'Office16_O365HomePremR_PIN26' }
        '286E0A48-550E-4AFE-A223-27D510DE9E3B' { 'Office16_O365HomePremR_PIN27' }
        'A4CB27DA-2524-4998-92AE-6A836124BF9F' { 'Office16_O365HomePremR_PIN28' }
        'DAA7B9D0-F65A-482B-8AD3-474A33A05BE2' { 'Office16_O365HomePremR_PIN29' }
        '44938520-350C-4919-8E2F-E840C99AF4BF' { 'Office16_O365HomePremR_PIN30' }
        'F1997D24-27E6-4350-A9C7-50E63F85406A' { 'Office16_O365HomePremR_PIN31' }
        '7F3D4AF1-E298-4C30-8118-A0533B436C43' { 'Office16_O365HomePremR_PIN32' }
        'CB9FE322-23F2-4FC5-8569-0E63D0853072' { 'Office16_O365HomePremR_PIN33' }
        'F3449F6D-D512-4BBC-AC02-8C654845F6CB' { 'Office16_O365HomePremR_PIN34' }
        '436055A7-25A6-40FF-A124-B43A216FD369' { 'Office16_O365HomePremR_PIN35' }
        '3B694869-1556-4339-98C2-96C893040E31' { 'Office16_O365HomePremR_PIN36' }
        '7BAA6D3A-9EA9-47A8-8DFF-DC33F63CFEB3' { 'Office16_O365HomePremR_PIN37' }
        'ee0f12ff-cc0d-449a-81a5-87b573cfc22e' { 'Win Next Pre-Release Education OEM:DM' }
        'd9a4b7ac-49db-4325-80c0-06501d7da41a' { 'Win Next Pre-Release Education Retail' }
        'e8ced63e-420d-4ab6-8723-aaf165efb5eb' { 'Win Next Pre-Release Education Volume:GVLK' }
        'ad724591-722d-457b-a9ad-691a1e89e7a5' { 'Win Next Pre-Release Education Volume:MAK' }
        '666dd2be-3c83-4756-9a1b-8ffb7067c8d9' { 'Win Next Pre-Release Education Volume:CSVLK' }
        '11FC26E1-ADC8-4BEE-B42A-5C57D5FEC516' { 'Office16_O365HomePremR_PIN38' }
        '396D571C-B08F-4BEE-BE0B-28C5B640BC23' { 'Office16_O365HomePremR_PIN39' }
        'BCEF3379-4C3F-46D6-9922-8D3E513E75FA' { 'Office16_O365HomePremR_PIN40' }
        'C299D07D-803A-423C-88E9-029DE50D79ED' { 'Office16_O365HomePremR_PIN41' }
        '8C4F02D4-30C0-441A-860D-A68BE9EFC1EE' { 'Office16_O365HomePremR_PIN42' }
        '89B643DB-DFA5-4AF4-AEFC-43D17D98B084' { 'Office16_O365HomePremR_PIN43' }
        'D7E4AF12-6EB0-40DA-BF0E-D818BBC62AFB' { 'Office16_O365HomePremR_PIN44' }
        '183C0D5A-5AAE-45EB-B0CE-88009B8B3939' { 'Office16_O365HomePremR_PIN45' }
        '2E8E87E2-ED03-4DFB-8B40-0F73785B43FD' { 'Office16_O365HomePremR_PIN46' }
        '6B102F6C-50D4-4137-BF9F-5E446348188B' { 'Office16_O365HomePremR_PIN47' }
        'BE161169-49EC-4277-9802-6C5964D96593' { 'Office16_O365HomePremR_PIN48' }
        'D495DE19-448F-4C7E-8343-E54D7F336582' { 'Office16_O365HomePremR_PIN49' }
        'E0ECE06B-9123-4314-9570-338573410DE7' { 'Office16_O365HomePremR_PIN50' }
        '1752DF1B-8314-4790-9DF8-585D0BF1D0E3' { 'Office16_O365HomePremR_PIN51' }
        '3CF36478-D8B9-4FF4-9B42-0EDC60415E6A' { 'Office16_O365HomePremR_PIN52' }
        'CCB0F52E-312E-406E-A13A-566AF3C6B91D' { 'Office16_O365HomePremR_PIN53' }
        '634C8BC9-357C-4A70-A6B1-C2A9BC1BF9E5' { 'Office16_O365HomePremR_PIN54' }
        'B6512468-269D-4910-AD2D-A6A3D769FEBA' { 'Office16_O365HomePremR_PIN55' }
        'FEDA65D8-640B-4220-B8AE-6E221A990258' { 'Office16_O365HomePremR_PIN56' }
        'F337DD12-BF19-456B-82ED-B022B3032737' { 'Office16_O365HomePremR_PIN57' }
        'CB5E4CFF-1C96-43CA-91F8-0559DBA5456C' { 'Office16_O365HomePremR_PIN58' }
        'C2B1EC65-443F-4B2A-BF99-B46B244F0179' { 'Office16_O365HomePremR_PIN59' }
        '943CDA82-BDAC-4298-981F-21E97303DCCE' { 'Office16_O365HomePremR_PIN60' }
        '991A2521-DBB2-436C-82EB-C1BF93AC46FD' { 'Office16_O365HomePremR_PIN61' }
        'ED7482AE-C31E-4B62-A7CB-9291A0D616D2' { 'Office16_O365HomePremR_PIN62' }
        '63F119BD-171E-4034-B98F-A85759367616' { 'Office16_O365HomePremR_PIN63' }
        '792DE587-45FD-4F49-AD84-BFD40087792C' { 'Office16_O365HomePremR_PIN64' }
        '90984839-248D-4746-8F55-C943CAB009CF' { 'Office16_O365HomePremR_PIN65' }
        '62CCF9BD-1F60-414A-B766-79E98E55283B' { 'Office16_O365HomePremR_PIN66' }
        'F600E366-4C93-4CF0-BED5-BF2398759E00' { 'Office16_O365HomePremR_PIN67' }
        '174F331D-103E-4654-B6BD-C86D5B259A1A' { 'Office16_O365HomePremR_PIN68' }
        'DEA194EA-A396-4F91-88F2-77E501C8B9D2' { 'Office16_O365HomePremR_PIN69' }
        'C5B6E8E0-AD3D-4712-A5C6-FB7E7CC4DA59' { 'Office16_O365HomePremR_PIN70' }
        'A9AF7310-F6E0-40E2-B44A-076B2BA7E118' { 'Office16_O365HomePremR_PIN71' }
        '1F3BF441-3BD5-4DC5-B3DA-DB90450866F4' { 'Office16_O365HomePremR_PIN72' }
        'BDA57528-BB32-43DB-8CF0-36A32372F527' { 'Office16_O365HomePremR_PIN73' }
        'F98827AD-4B5F-48F1-B81B-FEE63DF5858E' { 'Office16_O365HomePremR_PIN74' }
        'B333EAB2-86CB-4B08-A5B8-A4C64AFC7A4B' { 'Office16_O365HomePremR_PIN75' }
        'F988DF4F-10DF-444F-909F-679BB9DF70D2' { 'Office16_O365HomePremR_PIN76' }
        '4D57374B-F5EA-4513-BB95-0456E424BCEE' { 'Office16_O365HomePremR_PIN77' }
        '9AF02C45-EE74-4400-A4E7-1251D11780A0' { 'Office16_O365HomePremR_PIN78' }
        '9459DA1D-F113-416B-AB41-A81D1C29A7A0' { 'Office16_O365HomePremR_PIN79' }
        '04D62A0B-845D-48ED-A872-A064FCC56B07' { 'Office16_O365HomePremR_PIN80' }
        '5CA79892-8746-4F00-BB15-F3C799EDBCF4' { 'Office16_O365HomePremR_PIN81' }
        'E96A7A9C-162D-41E1-8C3D-D4C0929B6558' { 'Office16_O365HomePremR_PIN82' }
        '934ECDD6-7438-4464-B0FD-ED374AAB9CA6' { 'Office16_O365HomePremR_PIN83' }
        '5F1FB9D5-F241-4543-994F-36B37F888585' { 'Office16_O365HomePremR_PIN84' }
        'E5606A7D-8C29-4AD7-94B5-7427BF457616' { 'Office16_O365HomePremR_PIN85' }
        '4B9B31AA-00FA-481C-A25F-A2067F3FF24C' { 'Office16_O365HomePremR_PIN86' }
        '92B51A69-397D-4796-A5E8-D1672B349469' { 'Office16_O365HomePremR_PIN87' }
        '1AE119A6-40ED-4FA9-B52A-909841BD6E3F' { 'Office16_O365HomePremR_PIN88' }
        'FA25F074-80F9-44C1-B233-4019D3E70230' { 'Office16_O365HomePremR_PIN89' }
        '523AABDF-9353-4151-9179-F708A2B48F6B' { 'Office16_O365HomePremR_PIN90' }
        '85133BEE-AD80-4CB4-977B-F16FD2DC3A20' { 'Office16_O365HomePremR_PIN91' }
        '3DC943FD-4E44-4FD6-A05F-8B421FF1C68A' { 'Office16_O365HomePremR_PIN92' }
        '8978F58A-BDC1-418C-AB3E-8017859FCC1E' { 'Office16_O365HomePremR_PIN93' }
        '9156E89A-1370-4079-AAA5-695DC9CEEAA2' { 'Office16_O365HomePremR_PIN94' }
        'B7CD5DC5-A2E6-4E74-BA44-F16B81B931F2' { 'Office16_O365HomePremR_PIN95' }
        '87D9FF03-50F4-4247-83E7-32ED575F2B1B' { 'Office16_O365HomePremR_PIN96' }
        '064A3A09-3B2B-441D-A86B-F3D47F2D2EC6' { 'Office16_O365HomePremR_PIN97' }
        '09775609-A49B-4F28-97AE-7F7740415C66' { 'Office16_O365HomePremR_PIN98' }
        'C9693FD7-4024-4544-BF5B-45160F7D5687' { 'Office16_O365HomePremR_PIN99' }
        '52263C53-5561-4FD5-A88D-2382945E5E8B' { 'Office16_O365HomePremR_PIN100' }
        '02BB3A66-D796-4938-94E3-1D6FF2A96B5B' { 'Office16_O365HomePremR_PIN101' }
        'E6930809-6796-466F-BC45-F0937362FDC1' { 'Office16_O365HomePremR_PIN102' }
        '6516C530-02EA-49D9-AD33-A824902B1065' { 'Office16_O365HomePremR_PIN103' }
        'AA1A1140-B8A1-4377-BFF0-4DCFF82F6ED1' { 'Office16_O365HomePremR_PIN104' }
        '5770F497-3F1D-4396-A729-18677AFE6359' { 'Office16_O365HomePremR_PIN105' }
        '003D2533-6A8C-4163-9A4E-76376B21ED15' { 'Office16_O365HomePremR_PIN106' }
        '0B40C0DA-6C2C-4BB6-9C05-EF8B30F96668' { 'Office16_O365HomePremR_PIN107' }
        '59C95D45-74A6-405E-815B-99CF2692577A' { 'Office16_O365HomePremR_PIN108' }
        'ADE257E8-4824-497F-B767-C0D06CDA3E4E' { 'Office16_O365HomePremR_PIN109' }
        '2D40ED06-955E-4725-80FC-850CDCBC1396' { 'Office16_O365HomePremR_PIN110' }
        'B688E64D-6305-4CCF-9981-CBF6823B3F65' { 'Office16_O365HomePremR_PIN111' }
        '65A4C65F-780B-4B57-B640-2AEA70761087' { 'Office16_O365HomePremR_PIN112' }
        '7BBE17F2-24C7-416A-8821-A7ACAF91A4AA' { 'Office16_O365HomePremR_PIN113' }
        '5D8AAAF2-3EAB-48E0-822A-6EFAE35980F7' { 'Office16_O365HomePremR_PIN114' }
        'FDA59085-BDB9-4ADC-B9D7-4B5E7DFD3EAC' { 'Office16_O365HomePremR_PIN115' }
        'AB2A78FF-5C52-494A-AE2A-99C0E481CA99' { 'Office16_O365HomePremR_PIN116' }
        '9540C768-CEDF-401C-B27A-15DD833E7053' { 'Office16_O365HomePremR_PIN117' }
        '68c8ec62-6117-487f-a499-71a9ddee812d' { 'Win Next Pre-Release PPIPro Retail' }
        'c3ad289b-07ad-4330-b75a-54c390164bd5' { 'Win Next Pre-Release PPIPro Volume:MAK' }
        'b07ed79e-8f61-4cf8-86a1-09f55dd4df23' { 'Win Next Pre-Release Enterprise OEM:NONSLP' }
        'fc55254a-a294-4c21-98e1-c8ff416adb0b' { 'Win Next Pre-Release Enterprise OEM:DM' }
        '5CB09805-B7E8-44D3-BDF4-845071148E1C' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Isolated Shell Retail' }
        'CD5A607F-A545-4F76-BA1E-78ACAAA9D3EB' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Integrated Shell Retail' }
        '7D3CBCBB-90B1-411F-9981-6E28039A9B82' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Community Edition Retail' }
        'EBE15614-75B8-4549-8F01-9FB1DCF079D9' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Community Edition Retail' }
        'EF0AED0E-D3F8-4ED1-B60F-9DE4A29A5ED9' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Professional Retail Retail' }
        '0B7D8E82-93A8-4B4D-824B-53E584234AA8' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Professional Retail' }
        '7727F152-61C2-4491-9357-A6AECFA38EDB' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Premium Retail' }
        '0AEAE1AC-30C7-47B2-BFF3-539BB39DD3C8' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Premium Retail' }
        'F4D7232B-A870-4AA3-9C63-5D502B8D2451' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Ultimate Retail' }
        'E97017F4-2A10-4947-A4C3-D0EB58095060' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Ultimate Retail' }
        '9948249B-DCDC-4F3B-853F-361D70B6455B' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Test Professional Retail' }
        '859E9F22-91EE-419E-B99C-D5638D033E51' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Test Professional Retail' }
        '3242AFF0-B67A-4915-8C26-0646E2DA1733' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Team Foundation Server Retail' }
        'A3119BBA-2F97-4DB7-AF29-DD3535A416D1' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Team Foundation Server Retail' }
        'C8511341-A154-4E94-8F64-9B55FB2D4790' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Team Foundation Server Retail' }
        '80597EFA-4639-495D-A87E-078ADD1E5AFC' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Team Foundation Server Express Retail' }
        '09566F12-98CD-4D95-B154-4C9B31D009CA' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Release Management Server Retail' }
        '32A87CAF-C493-4FD7-9BDB-DBCCA2D9DB82' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Release Management Server Retail' }
        '39CCA174-0472-46AD-940E-FEDCBF7D3905' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Visual Studio Agents Retail' }
        'DAACAB16-9D63-4765-B956-E293F7376D86' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Test Agent Retail' }
        '24203E2F-FC54-4452-B79B-832622E3D55F' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Test Controller Retail' }
        'A44E1AEB-7ABA-4060-A389-D15A53AD9BB5' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Future Edition 1 Retail' }
        '5BFB74C0-9824-4E37-9CAC-FA47705A6095' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Future Edition 1 Retail' }
        '2764021B-2A06-46A2-BD7A-659ED152D760' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Future Edition 1 Retail' }
        '2F456BC3-A0C7-4EBB-9FF8-7FBF351D1D84' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Future Edition 2 Retail' }
        '068B3F6E-F5DF-44F4-9B84-9E9649AE7FAC' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Future Edition 2 Retail' }
        'A8C97567-179B-45D9-982B-CA87E91A1366' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Future Edition 2 Retail' }
        '2F161EB9-1F67-462E-99CE-A478BB32092D' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Future Edition 3 Retail' }
        'E0D58C8A-D4A3-49A1-BFA9-2CC29A07E06B' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Future Edition 3 Retail' }
        '0220C726-4FA6-4E58-A195-82C4974A8E54' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Future Edition 3 Retail' }
        '4CA35938-BE1D-46BB-A08A-FAC1891DD820' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Express for Windows Retail' }
        '22522B9B-2253-4EE4-9089-1D5AD012E393' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Express for Windows Retail' }
        '2B867754-CD01-4401-8800-250CC2FA5E4D' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Express for Desktop Retail' }
        '7BC65FD7-4C43-42A3-A16B-0FD32A1318DC' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Express for Desktop Retail' }
        '98C79277-A762-4949-85D6-E8329ADBE3FB' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Express for Web Retail' }
        '1FE0DF51-955C-49CA-808F-D7741FBFDC57' { 'Visual Studio 2015 RTM Retail Visual Studio 2015 RTM Express for Web Retail' }
        'C4783C6F-69B4-438D-BEAE-047834C64E35' { 'Visual Studio 2015 RTM Volume:MAK Visual Studio 2015 RTM Professional  Volume' }
        '1FE51BA1-DB1B-47A3-91F4-25BCD6FB365C' { 'Visual Studio 2015 RTM Volume:MAK Visual Studio 2015 RTM Ultimate Volume' }
        '0567073a-7d74-403b-b2d5-6b35da372d8d' { 'Win 10 RTM Core OEM:DM' }
        '8db63db6-4f8f-46d6-a448-66444faaaa72' { 'Win 10 RTM Core OEM:DM' }
        '30d469c6-a78f-4476-b5c8-af78d5b6a5fb' { 'Win 10 RTM Core OEM:NONSLP' }
        '2b1f36bb-c1cd-4306-bf5c-a0367c2d97d8' { 'Win 10 RTM Core Retail' }
        'e371d89a-73e8-4b24-a7ff-23a3641dd18e' { 'Win 10 RTM Core Retail' }
        '58e97c99-f377-4ef1-81d5-4ad5522b5fd8' { 'Windows 10 Home' }
        'b27bf099-cf06-499e-af17-de73ba94b316' { 'Win 10 RTM CoreCountrySpecific OEM:DM' }
        'f4fcb21e-34ca-4383-865a-ab4d36363e03' { 'Win 10 RTM CoreCountrySpecific OEM:NONSLP' }
        '1d1bac85-7365-4fea-949a-96978ec91ae0' { 'Win 10 RTM CoreCountrySpecific Retail' }
        'a9107544-f4a0-4053-a96a-1479abdef912' { 'Windows 10 Home Country Specific' }
        '8e518ff0-bab0-4ea1-a233-61338721bf0b' { 'Win 10 RTM CoreN OEM:DM' }
        '2479ad7a-fe16-43f2-aec8-b30a210fe303' { 'Win 10 RTM CoreN OEM:NONSLP' }
        'f742e4ff-909d-4fe9-aacb-3231d24a0c58' { 'Win 10 RTM CoreN Retail' }
        '06e74065-465d-4e14-ab23-c34a28aa54aa' { 'Win 10 RTM CoreN Retail' }
        '7b9e1751-a8da-4f75-9560-5fadfe3d8e38' { 'Windows 10 Home N' }
        'ed799377-74b8-4989-a244-14d082e65972' { 'Win 10 RTM CoreSingleLanguage OEM:DM' }
        '653098ee-780d-4863-8cf2-d18399ce413b' { 'Win 10 RTM CoreSingleLanguage OEM:DM' }
        '4002e33a-524c-4100-8108-131a0d42c0ea' { 'Win 10 RTM CoreSingleLanguage OEM:NONSLP' }
        '3ae2cc14-ab2d-41f4-972f-5e20142771dc' { 'Win 10 RTM CoreSingleLanguage Retail' }
        'cd918a57-a41b-4c82-8dce-1a538e221a83' { 'Windows 10 Home Single Language' }
        '1a9a717a-cf13-4ba5-83c3-0fe25fa868d5' { 'Win 10 RTM Education OEM:DM' }
        '2936d1d2-913a-4542-b54e-ce5a602a2a38' { 'Win 10 RTM Education OEM:NONSLP' }
        'e558417a-5123-4f6f-91e7-385c1c7ca9d4' { 'Win 10 RTM Education Retail' }
        'e0c42288-980c-4788-a014-c080d2e1926e' { 'Windows 10 Education' }
        'b4bfe195-541e-4e64-ad23-6177f19e395e' { 'Win 10 RTM Education Volume:MAK' }
        'dcca5ad8-d7aa-432b-8bf3-1829dfe7d0f2' { 'Win 10 RTM EducationN OEM:DM' }
        'c6c0a31e-7003-4dff-b4f9-ddc9f8d20af9' { 'Win 10 RTM EducationN OEM:NONSLP' }
        'c5198a66-e435-4432-89cf-ec777c9d0352' { 'Win 10 RTM EducationN Retail' }
        '3c102355-d027-42c6-ad23-2e7ef8a02585' { 'Windows 10 Education N' }
        '6ef518fa-b31e-4c71-851a-d10f61eccd54' { 'Win 10 RTM EducationN Volume:MAK' }
        '7cb546c0-c7d5-44d8-9a5c-69ecdd782b69' { 'Win 10 RTM Enterprise OEM:DM' }
        '8b351c9c-f398-4515-9900-09df49427262' { 'Win 10 RTM Enterprise OEM:NONSLP' }
        '73111121-5638-40f6-bc11-f1d7b0d64300' { 'Windows 10 Enterprise' }
        '2ffd8952-423e-4903-b993-72a1aa44cf82' { 'Win 10 RTM Enterprise Volume:MAK' }
        '3f4c0546-36c6-46a8-a37f-be13cdd0cf25' { 'Win 10 RTM EnterpriseEval Retail:TB:Eval' }
        'd6323d79-620e-4b82-bd5f-765e820d69e6' { 'Win 10 RTM EnterpriseS OEM:DM' }
        'faa57748-75c8-40a2-b851-71ce92aa8b45' { 'Win 10 RTM EnterpriseS OEM:NONSLP' }
        '7b51a46c-0c04-4e8f-9af4-8496cca90d5e' { 'Windows 10 Enterprise LTSB' }
        '6366a32b-72e4-4212-bf11-c22b0e98a435' { 'Win 10 RTM EnterpriseS Volume:MAK' }
        '57a4ebb6-8e0c-41f8-b79e-8872ddc971ef' { 'Win 10 RTM EnterpriseSEval Retail:TB:Eval' }
        '994578eb-193c-4c99-bea0-2483274c9afd' { 'Win 10 RTM EnterpriseSNEval Retail:TB:Eval' }
        'e272e3e2-732f-4c65-a8f0-484747d0d947' { 'Windows 10 Enterprise N' }
        'c83cef07-6b72-4bbc-a28f-a00386872839' { 'Win 10 RTM EnterpriseN Volume:MAK' }
        '1f8dbfe8-defa-4676-b5a6-f76949a01540' { 'Win 10 RTM EnterpriseNEval Retail:TB:Eval' }
        '87b838b7-41b6-4590-8318-5797951d8529' { 'Windows 10 Enterprise LTSB N' }
        '60c243e1-f90b-4a1b-ba89-387294948fb6' { 'Win 10 RTM EnterpriseSN Volume:MAK' }
        '2a6137f3-75c0-4f26-8e3e-d83d802865a4' { 'Win 10 RTM PPIPro OEM:NONSLP' }
        'bd3762d7-270d-4760-8fb3-d829ca45278a' { 'Win 10 RTM Professional OEM:DM' }
        '613d217f-7f13-4268-9907-1662339531cd' { 'Win 10 RTM Professional OEM:DM' }
        '221a02da-e2a1-4b75-864c-0a4410a33fdf' { 'Win 10 RTM Professional OEM:NONSLP' }
        '4de7cb65-cdf1-4de9-8ae8-e3cce27b9f2c' { 'Win 10 RTM Professional Retail' }
        '377333b1-8b5d-48d6-9679-1225c872d37c' { 'Win 10 RTM Professional Retail' }
        'b0773a15-df3a-4312-9ad2-83d69648e356' { 'Win 10 RTM Professional Retail' }
        '2de67392-b7a7-462a-b1ca-108dd189f588' { 'Windows 10 Professional' }
        '49cd895b-53b2-4dc4-a5f7-b18aa019ad37' { 'Win 10 RTM Professional Volume:MAK' }
        'ef51e000-2659-4f25-8345-3de70a9cf4c4' { 'Win 10 RTM Professional Volume:MAK' }
        'b6f26b97-8a82-4781-beef-1123952988f2' { 'Win 10 RTM ProfessionalN OEM:DM' }
        '1419d934-3a3f-46d4-8a5e-8594a56b9e6f' { 'Win 10 RTM ProfessionalN OEM:NONSLP' }
        '9fbaf5d6-4d83-4422-870d-fdda6e5858aa' { 'Win 10 RTM ProfessionalN Retail' }
        '9c4a7917-c857-4bd5-b109-d21866014b5c' { 'Win 10 RTM ProfessionalN Retail' }
        '8a9e86e9-057b-40ca-b11b-307d8f167ae8' { 'Win 10 RTM ProfessionalN Retail' }
        'a80b5abf-76ad-428b-b05d-a47d2dffeebf' { 'Win 10 RTM ProfessionalN Volume:GVLK' }
        '2ea9cf38-0d06-4ed0-a4be-66fc7c919a42' { 'Win 10 RTM ProfessionalN Volume:MAK' }
        '5694ba59-213b-468a-b2c9-82a4dd09877d' { 'Win 10 RTM ProfessionalN Volume:MAK' }
        'DAF2E6D5-1424-47B9-8820-42B32E4BC3A2' { 'Office16_AccessR_OEM_Perp' }
        'BFA358B0-98F1-4125-842E-585FA13032E6' { 'Office16_AccessR_Retail' }
        'BB6FE552-10FB-4C0E-A4BE-6B867E075735' { 'Office16_AccessR_Trial' }
        '9D9FAF9E-D345-4B49-AFCE-68CB0A539C7C' { 'Office16_AccessRuntimeR_Bypass' }
        '67C0FC0C-DEBA-401B-BF8B-9C8AD8395804' { 'Office Access 2016' }
        '3B2FA33F-CD5A-43A5-BD95-F49F3F546B0B' { 'Office16_AccessVL_MAK' }
        '740A90D3-A366-49FA-9845-1FA8257ED07B' { 'Office16_ExcelR_OEM_Perp' }
        '424D52FF-7AD2-4BC7-8AC6-748D767B455D' { 'Office16_ExcelR_Retail' }
        'A49503A7-3084-4140-B087-6B30B258F92E' { 'Office16_ExcelR_Trial' }
        'C3E65D36-141F-4D2F-A303-A842EE756A29' { 'Office Excel 2016' }
        '685062A7-6024-42E7-8C5F-6BB9E63E697F' { 'Office16_ExcelVL_MAK' }
        '2AA09C36-3E86-4580-8E8D-E67DFC13A5A6' { 'Office16_HomeBusinessDemoR_BypassTrial180' }
        'BEA06487-C54E-436A-B535-58AEC833F05B' { 'Office16_HomeBusinessR_OEM_Perp' }
        '522F8458-7D49-42FF-A93B-670F6B6176AE' { 'Office16_HomeBusinessR_Retail3' }
        '3E0F37CC-584B-46B1-873E-C44AD57D6605' { 'Office16_HomeBusinessR_Trial2' }
        '5F2C45C3-232D-43A1-AE90-40CD3462E9E4' { 'Office16_HomeStudentDemoR_BypassTrial180' }
        '6BBE2077-01A4-4269-BF15-5BF4D8EFC0B2' { 'Office16_HomeStudentPlusARMPreInstallR_OEM_ARM' }
        '090896A0-EA98-48AC-B545-BA5DA0EB0C9C' { 'Office16_HomeStudentARMPreInstallR_OEM_ARM' }
        '8E2E934E-C319-4CCE-962E-F0546FB0AA8E' { 'Office16_HomeStudentR_OEM_Perp' }
        'C28ACDB8-D8B3-4199-BAA4-024D09E97C99' { 'Office16_HomeStudentR_Retail' }
        '861343B3-3190-494C-A76E-A9215C7AE254' { 'Office16_HomeStudentR_Trial' }
        'BF3AB6CF-1B0D-4250-BAD9-4B61ECA25316' { 'Office16_MondoR_OEM_Perp' }
        'B21367DF-9545-4F02-9F24-240691DA0E58' { 'Office16_MondoR_Retail' }
        'D229947A-7C85-4D12-944B-7536B5B05B13' { 'Office16_MondoR_Trial' }
        '37256767-8FC0-4B6A-8B92-BC785BFD9D05' { 'Office16_MondoR_Subscription2' }
        'EE6555BB-7A24-4287-99A0-5B8B83C5D602' { 'Office16_MondoR_SubTrial2' }
        '9CAABCCB-61B1-4B4B-8BEC-D10A3C3AC2CE' { 'Office Mondo 2016' }
        '2CD0EA7E-749F-4288-A05E-567C573B2A6C' { 'Office16_MondoVL_MAK' }
        'D98FA85C-4FD0-40D4-895C-6CC11DF2899F' { 'Office16_OfficeLPK_Bypass' }
        '436366DE-5579-4F24-96DB-3893E4400030' { 'Office16_OneNoteFreeR_Bypass' }
        'F680A57C-24C4-4FDD-80A3-778877F63D0A' { 'Office16_OneNoteR_OEM_Perp' }
        '83AC4DD9-1B93-40ED-AA55-EDE25BB6AF38' { 'Office16_OneNoteR_Retail' }
        '04388DC4-ABCA-4924-B238-AC4273F8F74B' { 'Office16_OneNoteR_Trial' }
        'D8CACE59-33D2-4AC7-9B1B-9B72339C51C8' { 'Office OneNote 2016' }
        '23B672DA-A456-4860-A8F3-E062A501D7E8' { 'Office16_OneNoteVL_MAK' }
        '6FAC4EBC-930E-4DF5-AAAE-9FF5A36A7C99' { 'Office16_OutlookR_OEM_Perp' }
        '5A670809-0983-4C2D-8AAD-D3C2C5B7D5D1' { 'Office16_OutlookR_Retail' }
        'EC9D9265-9D1E-4ED0-838A-CDC20F2551A1' { 'Office Outlook 2016' }
        '50059979-AC6F-4458-9E79-710BCB41721A' { 'Office16_OutlookVL_MAK' }
        '17A89B14-4244-4B97-BF6B-76D586CF91D0' { 'Office16_PowerPointR_OEM_Perp' }
        'F32D1284-0792-49DA-9AC6-DEB2BC9C80B6' { 'Office16_PowerPointR_Retail' }
        'D70B1BBA-B893-4544-96E2-B7A318091C33' { 'Office Powerpoint 2016' }
        '9B4060C9-A7F5-4A66-B732-FAF248B7240F' { 'Office16_PowerPointVL_MAK' }
        '54FF28C4-56AD-4168-AB75-7207F98DE5EB' { 'Office16_ProfessionalR_OEM_Perp' }
        'D20B83AB-A959-4FA3-9C28-82C14D74285A' { 'Office16_ProjectLPK_Bypass' }
        '13104647-EE01-4016-AFAF-BBA564215D6E' { 'Office16_ProjectProDemoR_BypassTrial180' }
        '2A9E12E5-48A2-497C-98D3-BE7170D86B13' { 'Office16_ProjectProR_OEM_Perp' }
        '0F42F316-00B1-48C5-ADA4-2F52B5720AD0' { 'Office16_ProjectProR_Retail' }
        'AEEDF8F7-8832-41B1-A9C8-13F2991A371C' { 'Office16_ProjectProR_Trial' }
        '4F414197-0FC2-4C01-B68A-86CBB9AC254C' { 'Office Project Pro 2016' }
        '82F502B5-B0B0-4349-BD2C-C560DF85B248' { 'Office16_ProjectProVL_MAK' }
        '6185F4C9-522C-4808-8508-946D28CEA707' { 'Office16_ProjectStdR_OEM_Perp' }
        'E9F0B3FC-962F-4944-AD06-05C10B6BCD5E' { 'Office16_ProjectStdR_Retail' }
        'DA7DDABC-3FBE-4447-9E01-6AB7440B4CD4' { 'Office Project Standard 2016' }
        '82E6B314-2A62-4E51-9220-61358DD230E6' { 'Office16_ProjectStdVL_MAK' }
        '60AFA663-984D-47A6-AC9C-00346FF5E8F0' { 'Office16_ProPlusDemoR_BypassTrial180' }
        '596BF8EC-7CAB-4A98-83AE-459DB70D24E4' { 'Office16_ProPlusR_OEM_Perp2' }
        'DE52BD50-9564-4ADC-8FCB-A345C17F84F9' { 'Office16_ProPlusR_Retail' }
        'C8CE6ADC-EDE7-4CE2-8E7B-C49F462AB8C3' { 'Office16_ProPlusR_Trial' }
        'D450596F-894D-49E0-966A-FD39ED4C4C64' { 'Office Professional Plus 2016' }
        'C47456E3-265D-47B6-8CA0-C30ABBD0CA36' { 'Office16_ProPlusVL_MAK' }
        'AD96EEE1-FD16-4D77-8A5A-91B0C9A2369A' { 'Office16_PTK_Bypass' }
        '6BB0FF35-9392-4635-B209-642C331CF1EE' { 'Office16_PublisherR_OEM_Perp' }
        '6E0C1D99-C72E-4968-BCB7-AB79E03E201E' { 'Office16_PublisherR_Retail' }
        'FBD9E09F-6B81-4FFB-97EF-E8919A0C9E06' { 'Office16_PublisherR_Trial' }
        '041A06CB-C5B8-4772-809F-416D03D16654' { 'Office Publisher 2016' }
        'FCC1757B-5D5F-486A-87CF-C4D6DEDB6032' { 'Office16_PublisherVL_MAK' }
        '971CD368-F2E1-49C1-AEDD-330909CE18B6' { 'Office16_SkypeforBusinessEntryR_PrepidBypass' }
        '418D2B9F-B491-4D7F-84F1-49E27CC66597' { 'Office16_SkypeforBusinessR_Retail' }
        'BDB32189-C636-46CD-A011-FFB834B552D9' { 'Office16_SkypeforBusinessR_Trial' }
        'E7851824-6844-4D85-ABE7-7CA026FB3314' { 'Office16_SkypeforBusinessVDI_Bypass' }
        '83E04EE1-FA8D-436D-8994-D31A862CAB77' { 'Office Skype for Business 2016' }
        '03CA3B9A-0869-4749-8988-3CBC9D9F51BB' { 'Office16_SkypeforBusinessVL_MAK' }
        '4A31C291-3A12-4C64-B8AB-CD79212BE45E' { 'Office16_StandardR_Retail' }
        '6CE96173-4198-49FC-9924-CC8EEC1A7285' { 'Office16_StandardR_Trial' }
        'DEDFA23D-6ED1-45A6-85DC-63CAE0546DE6' { 'Office Standard 2016' }
        '0ED94AAC-2234-4309-BA29-74BDBB887083' { 'Office16_StandardVL_MAK' }
        'D4639CC7-7B3A-4AC6-99C4-B0AF9ACE7B27' { 'Office16_VisioLPK_Bypass' }
        'D0C2BC53-DB5F-4A9E-84AC-17C8862C27DA' { 'Office16_VisioProDemoR_BypassTrial180' }
        'ED967494-A18E-41A9-ABB8-9030C51BA685' { 'Office16_VisioProR_OEM_Perp' }
        '2DFE2075-2D04-4E43-816A-EB60BBB77574' { 'Office16_VisioProR_Retail' }
        'A17F9ED0-C3D4-4873-B3B8-D7E049B459EC' { 'Office16_VisioProR_Trial' }
        '6BF301C1-B94A-43E9-BA31-D494598C47FB' { 'Office Visio Pro 2016' }
        '295B2C03-4B1C-4221-B292-1411F468BD02' { 'Office16_VisioProVL_MAK' }
        '15265EDE-4272-4B92-9D47-EF584858D0AE' { 'Office16_VisioStdR_OEM_Perp' }
        'C76DBCBC-D71B-4F45-B5B3-B7494CB4E23E' { 'Office16_VisioStdR_Retail' }
        'AA2A7821-1827-4C2C-8F1D-4513A34DDA97' { 'Office Visio Standard 2016' }
        '44151C2D-C398-471F-946F-7660542E3369' { 'Office16_VisioStdVL_MAK' }
        '60F6C5C4-96C1-4FFB-9719-388276C61605' { 'Office16_WordR_OEM_Perp' }
        '1d873132-f09f-4eb2-bf5a-2e4fb48935e8' { 'Win 10 RTM Core OEM:DM' }
        '847bb612-a888-441f-a947-a684ddd9099f' { 'Win 10 RTM CoreCountrySpecific OEM:DM' }
        '8a292df8-d653-4057-8133-a0701792f912' { 'Win 10 RTM CoreSingleLanguage OEM:DM' }
        '2c293c26-a45a-4a2a-a350-c69a67097529' { 'Win 10 RTM Professional OEM:DM' }
        'CACAA1BF-DA53-4C3B-9700-11738EF1C2A5' { 'Office16_WordR_Retail' }
        'E52D2A85-80E5-435B-882F-8884792D8ABF' { 'Office16_WordR_Trial' }
        'BB11BADF-D8AA-470E-9311-20EAF80FE5CC' { 'Office Word 2016' }
        'C3000759-551F-4F4A-BCAC-A4B42CBF1DE2' { 'Office16_WordVL_MAK' }
        '6285E8B3-2D05-4954-BF85-65159DEEB966' { 'Office16_WordR_Grace' }
        'AC9C8FB4-387F-4492-A919-D56577AD9861' { 'Office16_HomeBusinessR_Retail2' }
        '86834D00-7896-4A38-8FAE-32F20B86FA2B' { 'Office16_HomeBusinessR_Retail' }
        '91AB0C97-4CBE-4889-ACA0-F0C9394046D7' { 'Office16_HomeBusinessR_OEM_Perp4' }
        '45C8342D-379D-4A4F-99C5-61141D3E0260' { 'Office16_HomeBusinessR_OEM_Perp2' }
        '327DAB29-B51E-4A29-9204-D83A3B353D76' { 'Office16_HomeBusinessR_OEM_Perp3' }
        '6379F5C8-BAA4-482E-A5CC-38ADE1A57348' { 'Office16_HomeBusinessR_Grace' }
        '3A4A2CF6-5892-484D-B3D5-FE9CC5A20D78' { 'Office16_HomeBusinessR_Trial' }
        'DFC79B08-1388-44E8-8CBE-4E4E42E9F73A' { 'Office16_AccessR_Grace' }
        '1ECBF9C7-7C43-483E-B2AD-06EF5C5744C4' { 'Office16_HomeStudentR_Grace' }
        '99D89E49-3F21-4D6E-BB17-3E4EE4FE8726' { 'Office16_HomeStudentR_Trial2' }
        '8507F630-BEE7-4833-B054-C1CA1A43990C' { 'Office16_MondoR_Grace' }
        'E7B23B5D-BDB1-495C-B7CE-CC13652ACF2F' { 'Office16_MondoR_BypassTrial180' }
        'CEBCF005-6D81-4C9E-8626-5D01C48B834A' { 'Office16_MondoR_SubTest2' }
        '66C66DB4-55EA-427B-90A8-B850B2B87FD0' { 'Office16_OneNoteR_Grace' }
        '6D47BDDA-2331-4956-A1D6-E57889F326AB' { 'Office16_OutlookR_Grace' }
        'E5101C42-817D-432D-9783-8C03134A51C2' { 'Office16_PowerPointR_Grace' }
        'CA5B3EEA-C055-4ACF-BC78-187DB21C7DB5' { 'Office16_ProjectProR_Grace' }
        '067DABCC-B31D-4350-96A6-4FCAD79CFBB7' { 'Office16_ProjectProR_Retail2' }
        '587BECE0-14F5-4039-AA1F-7CFCE036FCCC' { 'Office16_ProjectStdR_Grace' }
        'AA64F755-8A7B-4519-BC32-CAB66DEB92CB' { 'Office16_ProPlusR_OEM_Perp6' }
        '5829FD99-2B17-4BE4-9814-381145E49019' { 'Office16_ProPlusR_OEM_Perp4' }
        '6C1BED1D-0273-4045-90D2-E0836F3C380B' { 'Office16_ProPlusR_OEM_Perp' }
        '26B394D7-7AD7-4AAB-8FCC-6EA678395A91' { 'Office16_ProPlusR_OEM_Perp3' }
        '339A5901-9BDE-4F48-A88D-D048A42B54B1' { 'Office16_ProPlusR_OEM_Perp5' }
        '70D9CEB6-6DFA-4DA4-B413-18C1C3C76E2E' { 'Office16_ProPlusR_Grace' }
        '6CB2AFA8-FFFF-49FE-91CF-5FFBB0C9FD2B' { 'Office16_PublisherR_Grace' }
        '17C5A0EB-24EE-4EB3-91B6-6D9F9CB1ACF6' { 'Office16_SkypeforBusinessR_Grace' }
        'C7D96193-844A-44BD-93D0-76E4B785248E' { 'Office16_StandardR_Grace' }
        '5821EC16-77A9-4404-99C8-2756DC6D4C3C' { 'Office16_VisioProR_Grace' }
        'AD310F32-BD8D-40AD-A882-BC7FCBAD5259' { 'Office16_VisioStdR_Grace' }
        'FC61B360-59EE-41A2-8586-E66E7B43DB89' { 'Office16_ExcelR_Grace' }
        '1F7413CF-88D2-4F49-A283-E4D757D179DF' { 'Office16_VisioProR_Retail2' }
        '1114B902-9BFE-4A7C-BA7C-1A7DB3669D67' { 'Office16_KMSHostVL_KMS_Host' }
        '975c04ad-b6f5-497b-ab68-8ea833df55ca' { 'Win Next Pre-Release EducationN OEM:DM' }
        'ee2d7795-bd4a-4c97-b1b5-a1f275f6c53d' { 'Win Next Pre-Release EducationN Retail' }
        '3885bca5-11c1-4d4e-9395-df38f7f09a0e' { 'Win Next Pre-Release EducationN Volume:GVLK' }
        '9e40a9eb-5a34-481d-83ef-ef76093a7838' { 'Win Next Pre-Release EducationN Volume:MAK' }
        'b428b85d-3c13-4fd9-beb0-187fc6bffe28' { 'Win Next Pre-Release Core Retail' }
        'd9cde13d-0a9a-4941-a79a-8ad10a865a08' { 'Win Next Pre-Release Core Retail' }
        'b753d452-dc93-4333-90cc-841f0e21c946' { 'Win Next Pre-Release Professional Retail' }
        '5ce7f628-2651-42fc-9d9b-51a89dc30ae3' { 'Win Next Pre-Release Professional Retail' }
        'aa234c15-ee34-4e5f-adb5-73afafb77143' { 'Win Next Pre-Release ProfessionalS Volume:GVLK' }
        'd0fe039e-737b-4cf4-b360-b83d7ca11b2d' { 'Win Next Pre-Release ProfessionalS Volume:MAK' }
        '9f6a1bc9-5278-4991-88c9-7301c87a75ea' { 'Win Next Pre-Release ProfessionalSN Volume:GVLK' }
        '43ce53cf-5981-4db8-a4f8-7c941b983b4a' { 'Win Next Pre-Release ProfessionalSN Volume:MAK' }
        '5b92ee7e-7337-4414-afad-4381bb01ace9' { 'Win Next Pre-Release EnterpriseS OEM:DM' }
        'c3a9484a-d8b4-419b-b76c-d351c685c330' { 'Win Next Pre-Release EnterpriseS OEM:NONSLP' }
        'cc52a105-c546-421c-9afc-29ec31df395c' { 'Win Next Pre-Release EnterpriseS Volume:MAK' }
        '75d003b0-dc66-42c0-b3a1-308a3f35741a' { 'Win Next Pre-Release EnterpriseS Volume:GVLK' }
        '1454334d-0849-4b13-8bbf-823f77784e6f' { 'Win Next Pre-Release EnterpriseSN OEM:DM' }
        '43a3c3aa-8f0a-48a8-8180-d044d4c20ac4' { 'Win Next Pre-Release EnterpriseSN OEM:NONSLP' }
        '91ea6d7b-a3d3-43e7-96ae-77a0de1dc57c' { 'Win Next Pre-Release EnterpriseSN Volume:MAK' }
        '4e4d5504-e7b1-419c-913d-3c80c15294fc' { 'Win Next Pre-Release EnterpriseSN Volume:GVLK' }
        'edb719c2-0fe8-46cf-8fe0-982de0efb593' { 'Win Next Pre-Release EnterpriseSEval Retail:TB:Eval' }
        'a56d1524-4a45-4f7c-955e-3266396ffcbb' { 'Win Next Pre-Release EnterpriseSNEval Retail:TB:Eval' }
        '81f9b6d3-8aa5-43d3-abbb-8f8e226e2c63' { 'Win Next Pre-Release MobileCore Retail' }
        '71153417-69a6-4767-84e3-dd75ad09b44c' { 'Win Next Pre-Release MobileEnterprise Volume:MAK' }
        '1b2ef881-b286-4421-95f4-8fdbaf54fb34' { 'Windows Server Next Beta ServerHI Retail' }
        'bec01b9a-b3aa-41e0-a05c-4f8090a189be' { 'Windows Server Next Beta ServerHI Volume:MAK' }
        'b995b62c-eae2-40aa-afb9-111889a84ef4' { 'Windows Server Next Beta ServerHI Volume:GVLK' }
        '1d585177-c65f-4a8e-891e-1e7e500b0184' { 'Windows Server Next Beta ServerHI OEM:NONSLP' }
        '9ffa2310-815d-4328-8de2-8668ef8ca775' { 'Windows Server Next Beta ServerHI OEM:SLP' }
        'df055aa8-e102-4e22-a1b5-e78a0f9d42e2' { 'Windows Server Next Beta ServerHI VT:IA' }
        '411b3d4f-be6d-4a06-baaa-9cabfc256cae' { 'Win 10 RTM Core Retail' }
        '74436dbb-cc17-46de-867f-14906ba4a938' { 'Win 10 RTM Core Retail' }
        'c86d5194-4840-4dae-9c1c-0301003a5ab0' { 'Win 10 RTM Professional Retail' }
        'd6eadb3b-5ca8-4a6b-986e-35b550756111' { 'Win 10 RTM Professional Retail' }
        'ee8464ba-bcf0-4af1-b1b1-b1850b91bfa9' { 'Windows Server Next Beta ServerARM64 Retail' }
        'E1FEF7E5-6886-458C-8E45-7C1E9DAAB00C' { 'Office16_ProPlusR_Trial2' }
        '84832881-46EF-4124-8ABC-EB493CDCF78E' { 'Office16_ProPlusMSDNR_Retail' }
        '7A0560C5-21ED-4518-AD41-B7F870B9FD1A' { 'Office16_ProfessionalR_Grace' }
        'EB264A11-A2EE-4740-8AC2-3751C8859374' { 'Office16_ProfessionalDemoR_BypassTrial180' }
        '39A1BE8C-9E7F-4A75-81F4-21CFAC7CBECB' { 'Office16_ProfessionalR_Trial' }
        'D64EDC00-7453-4301-8428-197343FAFB16' { 'Office16_ProfessionalR_Retail' }
        '2CB19A15-BAB2-4FCB-ACEE-4BDE5BE207A5' { 'Office16_ProjectProMSDNR_Retail' }
        '3846A94F-3005-401E-B663-AF1CF99813D5' { 'Office16_VisioProMSDNR_Retail' }
        '2395220C-BE32-4E64-81F2-6D0BDDB03EB1' { 'Office16_StandardMSDNR_Retail' }
        'E48D4EBB-FD30-43B2-BE87-0EB2335EC2C9' { 'Office16_PowerPointR_Trial' }
        'A9F645A1-0D6A-4978-926A-ABCB363B72A6' { 'Office16_PersonalR_Retail' }
        '2DCD3F0B-AAFB-48D7-9F5F-01E14160AC43' { 'Office16_OutlookR_Trial' }
        '5B45E2C1-3D5A-4C24-AD16-B26499F64FC2' { 'Office16_WacServerLPK_Bypass' }
        '338E5858-1E3A-4ACD-900E-7DBEF543BB9B' { 'Office16_PersonalDemoR_BypassTrial180' }
        'B444EF2B-340F-4E88-9E32-FCB747EE5D04' { 'Office16_PersonalR_Grace' }
        'E66E9AA9-D6CE-43DA-8A34-EF62ECDAE720' { 'Office16_PersonalR_OEM_Perp' }
        'FBBC4AAB-247A-43DB-8CE6-69ABE89A82E5' { 'Office16_PersonalR_Trial' }
        '35EC6E0E-2DF4-4629-9EE3-D525E806B988' { 'Office16_O365ProPlusDemoR_BypassTrial180' }
        '7AB38A1C-A803-4CA5-8EBB-F8786C4B4FAA' { 'Office16_O365HomePremDemoR_BypassTrial180' }
        '18C10CE7-C025-4615-993C-2E0C32F38EFA' { 'Office16_O365SmallBusPremDemoR_BypassTrial180' }
        '81D507D6-E729-436D-AD4D-FED2CBE4E566' { 'Office16_O365StandardDemoR_BypassTrial180' }
        '8BF9E61F-3905-4E9B-99C4-1C3946C1FCA7' { 'Office16_O365PersonalRDemoR_BypassTrial180' }
        '0C6911A0-1FD3-4425-A4B3-DA478D3BF807' { 'Office16_O365HomeBusinessDemoR_BypassTrial180' }
        'E914EA6E-A5FA-4439-A394-A9BB3293CA09' { 'Office Mondo R 2016' }
        '056B6D4F-6EED-4E7B-8346-314064B8A202' { 'Visual Studio 2015 Professional Visual Studio 2015 RTM Professional Volume' }
        '369B5C51-6454-4724-9831-72773DF9D004' { 'Visual Studio 2015 Enterprise Visual Studio 2015 RTM Enterprise Volume' }
        'DE8390A1-A21B-4853-A183-6771C7CAAB31' { 'Visual Studio 2015 Premium Visual Studio 2015 RTM Premium Volume' }
        '66DC4A32-C7E5-420B-BFC6-73429142E084' { 'Visual Studio 2015 Test Professional Visual Studio 2015 RTM Test Professional Volume' }
        '4267FE83-561C-4C72-BFC2-19AB57D4673C' { 'Visual Studio 2015 Team Foundation Server Visual Studio 2015 RTM Team Foundation Server Volume' }
        '97D718DC-CDD1-4F5E-B4F9-2049AACD5EF9' { 'Visual Studio 2015 Future Visual Studio SKU - 1 Visual Studio 2015 RTM Future Visual Studio SKU - 1 Volume' }
        'CF6602FA-6C0D-4D1E-AC56-312E686FB40C' { 'Visual Studio 2015 Future Visual Studio SKU - 2 Visual Studio 2015 RTM Future Visual Studio SKU - 2 Volume' }
        'AFB937C7-C951-47FC-8432-338302E21693' { 'Visual Studio 2015 Future Visual Studio SKU - 3 Visual Studio 2015 RTM Future Visual Studio SKU - 3 Volume' }
        'c082c31b-2c4f-4e07-94d7-9181fa802c4b' { 'Win 10 RTM Professional OEM:DM' }
        'fe74f55b-0338-41d6-b267-4a201abe7285' { 'Win 10 RTM Professional OEM:DM' }
        '040fa323-92b1-4baf-97a2-5b67feaefddb' { 'Win 10 RTM Professional OEM:DM' }
        '4053f6e4-20bb-49f2-b808-8385c48b5cd5' { 'Win 10 RTM ProfessionalN OEM:DM' }
        '6ccd24e5-8cc4-49ae-8996-dcfdcb4e1dc2' { 'Win 10 RTM ProfessionalN OEM:DM' }
        '1b750385-9fe2-49a8-ab55-149d0546395b' { 'Win 10 RTM Core OEM:DM' }
        'd7fb0c28-1eea-4f68-98a1-f988aa838ab5' { 'Win 10 RTM CoreCountrySpecific OEM:DM' }
        'da9621af-f086-4244-b563-18611e51aa1a' { 'Win 10 RTM CoreSingleLanguage OEM:DM' }
        '3df374ef-d444-4494-a5a1-4b0d9fd0e203' { 'Win 10 RTM Professional OEM:DM' }
        'f2fcf500-9451-458a-b15c-b80e6889c838' { 'Win 10 Pre-Release Core OEM:DM' }
        '0e670d3a-4b91-49c4-bc4a-f4b0a7c13c0c' { 'Win 10 Pre-Release Core OEM:NONSLP' }
        '8856f6c4-77b5-43e8-9d3a-f743888913ee' { 'Win 10 Pre-Release Core Retail' }
        '63ccfe35-779e-4eff-b5d8-6f849505c39c' { 'Win 10 Pre-Release Core Retail Qihoo' }
        'a8be2409-e3b4-4bf1-a9ce-836d1fc05c60' { 'Win 10 Pre-Release Core Retail Tencent' }
        '903663f7-d2ab-49c9-8942-14aa9e0a9c72' { 'Win 10 Pre-Release Core Volume:GVLK' }
        'b2646afb-f245-467b-9517-582504b034f8' { 'Win 10 Pre-Release CoreCountrySpecific OEM:DM' }
        '46169c68-8fa2-44ee-96cb-242335aa62b0' { 'Win 10 Pre-Release CoreCountrySpecific OEM:NONSLP' }
        'c7a55d06-d7f2-45b1-a958-d852a2cc94d3' { 'Win 10 Pre-Release CoreCountrySpecific Retail' }
        '5fe40dd6-cf1f-4cf2-8729-92121ac2e997' { 'Win 10 Pre-Release CoreCountrySpecific Volume:GVLK' }
        '37c6e24e-2669-41f2-867d-b6767a443e8d' { 'Win 10 Pre-Release CoreN OEM:DM' }
        '77318260-37ff-4410-b28b-a149e4bb4684' { 'Win 10 Pre-Release CoreN OEM:NONSLP' }
        'f028b8c4-f54d-4ee0-97f1-48502f4af598' { 'Win 10 Pre-Release CoreN Retail' }
        '4dfd543d-caa6-4f69-a95f-5ddfe2b89567' { 'Win 10 Pre-Release CoreN Volume:GVLK' }
        'caaaaf3a-6f46-4a83-9094-da92d38ee35d' { 'Win 10 Pre-Release CoreSingleLanguage OEM:DM' }
        '537b020e-62f4-475f-86e4-f038356561c5' { 'Win 10 Pre-Release CoreSingleLanguage OEM:NONSLP' }
        'da64e00c-413b-407c-b1d4-b0fc6e97b98d' { 'Win 10 Pre-Release CoreSingleLanguage Retail' }
        '2cc171ef-db48-4adc-af09-7c574b37f139' { 'Win 10 Pre-Release CoreSingleLanguage Volume:GVLK' }
        '8b3fc788-6c0b-4b3d-82dd-2b1e7923407d' { 'Win 10 Pre-Release Education OEM:DM' }
        'c09363ee-4046-46c0-901e-0d01341dcd74' { 'Win 10 Pre-Release Education OEM:NONSLP' }
        '7435e630-1e22-4a6d-b5e0-6959c45bb3a7' { 'Win 10 Pre-Release Education Retail' }
        'af43f7f0-3b1e-4266-a123-1fdb53f4323b' { 'Win 10 Pre-Release Education Volume:GVLK' }
        'ee8f3776-2116-4906-b822-520d1b94ec07' { 'Win 10 Pre-Release Education Volume:MAK' }
        '664ff3e7-2eb8-411b-a613-a06a5f619023' { 'Win 10 Pre-Release EducationN OEM:DM' }
        'd7b97bfb-419c-4242-9f09-2644de4c6b27' { 'Win 10 Pre-Release EducationN OEM:NONSLP' }
        'fc69cf0f-7d52-4652-abb8-2224fdfea2c4' { 'Win 10 Pre-Release EducationN Retail' }
        '075aca1f-05d7-42e5-a3ce-e349e7be7078' { 'Win 10 Pre-Release EducationN Volume:GVLK' }
        '418f2cbe-3b02-407d-b123-a43d8adf488c' { 'Win 10 Pre-Release EducationN Volume:MAK' }
        'c256d07a-9920-4023-abd0-e13d28b632a6' { 'Win 10 Pre-Release Enterprise OEM:DM' }
        'aac18c3a-3547-4e40-8ee5-27828e7d55cd' { 'Win 10 Pre-Release Enterprise OEM:NONSLP' }
        '43f2ab05-7c87-4d56-b27c-44d0f9a3dabd' { 'Win 10 Pre-Release Enterprise Volume:GVLK' }
        '904d2bb0-fa5e-4eec-b8b9-49cc37bdfa64' { 'Win 10 Pre-Release Enterprise Retail' }
        '19f9657f-3a93-44b7-8695-fb3670a913ea' { 'Win 10 Pre-Release Enterprise Volume:MAK' }
        '46fd674f-ca94-4597-b5a1-e9f76dbc763e' { 'Win 10 Pre-Release EnterpriseEval Retail:TB:Eval' }
        '7233e813-05e1-4353-9b77-c8b41f31895a' { 'Win 10 Pre-Release EnterpriseS Retail' }
        '681dca0c-c515-446b-a565-ef32efdeb3a1' { 'Win 10 Pre-Release EnterpriseS OEM:DM' }
        'f0a14f5e-9dcb-495c-9b75-9d622a20bf6e' { 'Win 10 Pre-Release EnterpriseS OEM:NONSLP' }
        '2cf5af84-abab-4ff0-83f8-f040fb2576eb' { 'Win 10 Pre-Release EnterpriseS Volume:GVLK' }
        'bc78bd80-eea5-46ca-8d94-d16f630b509f' { 'Win 10 Pre-Release EnterpriseS Volume:MAK' }
        '04a0dd50-94b1-408e-8e35-6b3605924f2f' { 'Win 10 Pre-Release EnterpriseSEval Retail:TB:Eval' }
        '162d36f0-b82d-4feb-9f07-8d812b3ec8ee' { 'Win 10 Pre-Release EnterpriseSNEval Retail:TB:Eval' }
        '6ae51eeb-c268-4a21-9aae-df74c38b586d' { 'Win 10 Pre-Release EnterpriseN Volume:GVLK' }
        '288850e5-f87a-4f40-a866-1a0f9af8ee46' { 'Win 10 Pre-Release EnterpriseN Retail' }
        '24d6bdff-ee06-4dbc-86b8-60c9c725f410' { 'Win 10 Pre-Release EnterpriseN Volume:MAK' }
        '1abd7741-ee05-490f-8fb2-937eed8bd2a4' { 'Win 10 Pre-Release EnterpriseNEval Retail:TB:Eval' }
        '11a37f09-fb7f-4002-bd84-f3ae71d11e90' { 'Win 10 Pre-Release EnterpriseSN Volume:GVLK' }
        '57f7c09e-84fa-4632-b3e9-f391eafa697e' { 'Win 10 Pre-Release EnterpriseSN OEM:DM' }
        '904e7989-5fe4-4a12-b40c-a4a44a00af9e' { 'Win 10 Pre-Release EnterpriseSN OEM:NONSLP' }
        'cafa30cc-de00-4a28-87f2-cc7af17b6cb8' { 'Win 10 Pre-Release EnterpriseSN Volume:MAK' }
        '5b2add49-b8f4-42e0-a77c-adad4efeeeb1' { 'Win 10 Pre-Release PPIPro Volume:GVLK' }
        '6e411c0d-ce3d-4e53-8ff8-1779c91b8f3d' { 'Win 10 Pre-Release PPIPro OEM:NONSLP' }
        'be217e5a-ff5f-475b-907b-87ba366d9d7b' { 'Win 10 Pre-Release Professional OEM:DM' }
        'f50d9f08-f6ac-4deb-8901-b622be45c219' { 'Win 10 Pre-Release Professional OEM:NONSLP' }
        '4029f3ed-9005-4f26-80af-ac5edf36d672' { 'Win 10 Pre-Release Professional Retail' }
        '54240757-b78e-4832-abe1-48bcabba3e7e' { 'Win 10 Pre-Release Professional Retail Qihoo' }
        '890e6fc5-409d-46af-8b01-aaf7ce5feb9f' { 'Win 10 Pre-Release Professional Retail Tencent' }
        'ff808201-fec6-4fd4-ae16-abbddade5706' { 'Win 10 Pre-Release Professional Volume:GVLK' }
        '39392b1e-b8a3-489f-a644-7d0bfd0dffa3' { 'Win 10 Pre-Release Professional Volume:MAK' }
        'f7f0e311-9b71-4642-bb39-7fbafea39af2' { 'Win 10 Pre-Release ProfessionalN OEM:DM' }
        '2916b691-f0af-458e-b6c2-e9c3d243a1e0' { 'Win 10 Pre-Release ProfessionalN OEM:NONSLP' }
        'b275ed94-692e-4188-bc03-b32e2b103a9e' { 'Win 10 Pre-Release ProfessionalN Retail' }
        '34260150-69ac-49a3-8a0d-4a403ab55763' { 'Win 10 Pre-Release ProfessionalN Volume:GVLK' }
        '67ae1663-ff9d-43f6-af4a-21ad402e2eca' { 'Win 10 Pre-Release ProfessionalN Volume:MAK' }
        '46fc26ea-6671-4d0f-955b-7d984f0bcdad' { 'Win 10 Pre-Release MobileCore Retail' }
        'ba782239-2781-43bd-b6ce-9fbeb5cec154' { 'Win 10 Pre-Release MobileEnterprise Volume:MAK' }
        '772e3d13-2cbc-4256-9086-c92967dfa9a8' { 'Win 10 Pre-Release CoreARM OEM:DM' }
        '3a2da408-3bd6-4496-b4eb-31effe3efc60' { 'Win 10 Pre-Release CoreARM OEM:NONSLP' }
        'b554b49f-4d57-4f08-955e-87886f514d49' { 'Win 10 Pre-Release CoreARM Volume:GVLK' }
        '95c0226a-de13-4159-ab61-08adbbabecf2' { 'Win 10 Pre-Release CoreConnected OEM:DM' }
        '6d6b352f-5210-4ac6-a432-82b2c5579a3e' { 'Win 10 Pre-Release CoreConnected OEM:NONSLP' }
        '541a0918-6b3e-4595-8d3a-3c889338847c' { 'Win 10 Pre-Release CoreConnected Retail' }
        '827a0032-dced-4609-ab6e-16b9d8a40280' { 'Win 10 Pre-Release CoreConnected Volume:GVLK' }
        '6c90b1af-5ca1-4098-844e-b42777e9445b' { 'Win 10 Pre-Release CoreConnected Volume:MAK' }
        '526b6782-2a45-4ff9-8b7c-8f1e19db3cd1' { 'Win 10 Pre-Release CoreConnectedN OEM:DM' }
        'b575fab6-9187-44c9-b1bf-3deceaec87a8' { 'Win 10 Pre-Release CoreConnectedN OEM:NONSLP' }
        '472d65dc-c533-4aae-a4d2-7daee5620cee' { 'Win 10 Pre-Release CoreConnectedN Retail' }
        'f18bbe32-16dc-48d4-a27b-5f3966f82513' { 'Win 10 Pre-Release CoreConnectedN Volume:GVLK' }
        'c09bb9a9-af72-4cfb-b6c0-edc238abfaa7' { 'Win 10 Pre-Release CoreConnectedN Volume:MAK' }
        'fbdf0513-3b09-461c-a45f-2c39f2d326f4' { 'Win 10 Pre-Release CoreConnectedCountrySpecific OEM:DM' }
        'ae42368e-9d6a-486c-9f73-64933b2461aa' { 'Win 10 Pre-Release CoreConnectedCountrySpecific OEM:NONSLP' }
        '7772d64d-d189-4cd1-8902-aab838ed40f2' { 'Win 10 Pre-Release CoreConnectedCountrySpecific Retail' }
        'b5fe5eaa-14cc-4075-84ae-57c0206d1133' { 'Win 10 Pre-Release CoreConnectedCountrySpecific Volume:GVLK' }
        'b5f6b2dc-e971-4a55-badc-92d3b93a6a24' { 'Win 10 Pre-Release CoreConnectedCountrySpecific Volume:MAK' }
        '4a7c156a-267a-4840-9cad-7cbe91189dac' { 'Win 10 Pre-Release CoreConnectedSingleLanguage OEM:DM' }
        '047fc935-aa04-44ac-bf6a-7696e5b72983' { 'Win 10 Pre-Release CoreConnectedSingleLanguage OEM:NONSLP' }
        'fbad2609-b6b3-490f-afb6-ba35f755367e' { 'Win 10 Pre-Release CoreConnectedSingleLanguage Retail' }
        '964a60f6-1505-4ddb-af03-6a9ce6997d3b' { 'Win 10 Pre-Release CoreConnectedSingleLanguage Volume:GVLK' }
        '097b6c36-1773-4098-8b42-7798f835bdd5' { 'Win 10 Pre-Release CoreConnectedSingleLanguage Volume:MAK' }
        '850f2956-7708-4440-81f5-23af2ea83694' { 'Win 10 Pre-Release ProfessionalStudent OEM:DM' }
        'a9c39ea6-5ccb-4c9a-a114-7cb8ca215640' { 'Win 10 Pre-Release ProfessionalStudent OEM:NONSLP' }
        '4008dd3d-c4e3-4a77-8ad4-4ddaace56736' { 'Win 10 Pre-Release ProfessionalStudent Retail' }
        '49066601-00dc-4d2c-83a8-4343a7b990d1' { 'Win 10 Pre-Release ProfessionalStudent Volume:GVLK' }
        'f1bef60f-7d6b-48f5-891c-70faf3aa36cc' { 'Win 10 Pre-Release ProfessionalStudent Volume:MAK' }
        '4d8e61f5-0ce8-4f5d-9c2d-41f0f6dacc7a' { 'Win 10 Pre-Release ProfessionalStudentN OEM:DM' }
        '35fc726d-c8da-479e-984d-45a0a404293c' { 'Win 10 Pre-Release ProfessionalStudentN OEM:NONSLP' }
        '36ca82dc-a4af-4d86-8de6-6f34f26d7cb9' { 'Win 10 Pre-Release ProfessionalStudentN Retail' }
        'bd64ebf7-d5ec-44c5-ba00-6813441c8c87' { 'Win 10 Pre-Release ProfessionalStudentN Volume:GVLK' }
        'dd3de47c-4c29-4d49-9033-bbfd88cf6bcc' { 'Win 10 Pre-Release ProfessionalStudentN Volume:MAK' }
        '296aa36a-9d4a-4a8b-9f1e-ed0ac0d7e8d8' { 'Win 10 Pre-Release ProfessionalS Retail' }
        'b15187db-11c6-4f13-91ca-8121cebf5b88' { 'Win 10 Pre-Release ProfessionalS Volume:GVLK' }
        'd7cb6d8f-4e96-4292-ad2a-0ae395d30b41' { 'Win 10 Pre-Release ProfessionalS Volume:MAK' }
        'f277652c-19fb-4c94-9b43-1e7a53f832bf' { 'Win 10 Pre-Release ProfessionalSN Retail' }
        '6cdbc9fb-63f5-431b-a5c0-c6f19ae26a9b' { 'Win 10 Pre-Release ProfessionalSN Volume:GVLK' }
        '1237c0cb-e392-4382-8f12-e45b0b73bad7' { 'Win 10 Pre-Release ProfessionalSN Volume:MAK' }
        'cc17e18a-fa93-43d6-9179-72950a1e931a' { 'Win 10 Pre-Release ProfessionalWMC Volume:GVLK' }
        '9a49e8d9-88e4-4397-92e1-4a8d84674b33' { 'Win 10 Pre-Release ProfessionalWMC Retail' }
        'be3fd8b4-c6d9-4d9c-816f-9e75c7e97b13' { 'Win 10 Pre-Release APPXLOB-Client Volume:MAK' }
        '1DA17564-ED4C-47E4-B3CA-3BCAB52AC07D' { 'Visual Studio 2015 PRERELEASE ALL Visual Studio 2015 PRERELEASE ALL Retail' }
        'c13f751b-250e-49ef-85f9-333433be7691' { 'Win 10 Pre-Release Professional Retail' }
        '3ff68d75-0fa3-43c2-8249-7c4ec9c26f85' { 'Win 10 Pre-Release ProfessionalN Retail' }
        '8859e3f7-43b0-4a38-87cb-ca00202651c6' { 'Win 10 RTM AnalogOneCore Retail' }
        'ee7b1257-5c57-42b4-9fe8-4915deb2f679' { 'Win 10 RTM AnalogOneCoreEnterprise Volume:MAK' }
        '327C6E89-97A1-4441-AD56-63B801C8C542' { 'CRM 8 Beta Enterprise Server Volume:GVLK' }
        'CFE8181E-75EE-4843-B1B0-F0DEFFDA6925' { 'CRM 8 Beta Enterprise Server Retail' }
        '01BEB5F2-A6C5-47B5-A6B5-26942519DA06' { 'CRM 8 Beta Online Server Retail' }
        'DCA32113-0526-4688-8137-55AEF56FAE0D' { 'CRM 8 Beta Service Provider Volume:GVLK' }
        'F149BC3D-D55A-482A-964B-C75A7D67B382' { 'CRM 8 Beta Workgroup Server Volume:GVLK' }
        'FD0963D6-D848-43E3-BEBA-1BCFB1077700' { 'CRM 8 Beta Workgroup Server Retail' }
        '829B8110-0E6F-4349-BCA4-42803577788D' { 'Office16_ProjectProXC2RVL_KMS_ClientC2R' }
        'CBBACA45-556A-4416-AD03-BDA598EAA7C8' { 'Office16_ProjectStdXC2RVL_KMS_ClientC2R' }
        'B234ABE3-0857-4F9C-B05A-4DC314F85557' { 'Office16_VisioProXC2RVL_KMS_ClientC2R' }
        '361FE620-64F4-41B5-BA77-84F8E079B1F7' { 'Office16_VisioStdXC2RVL_KMS_ClientC2R' }
        '0594DC12-8444-4912-936A-747CA742DBDB' { 'Office16_VisioProXC2RVL_MAKC2R' }
        '1D1C6879-39A3-47A5-9A6D-ACEEFA6A289D' { 'Office16_VisioStdXC2RVL_MAKC2R' }
        '16728639-A9AB-4994-B6D8-F81051E69833' { 'Office16_ProjectProXC2RVL_MAKC2R' }
        '431058F0-C059-44C5-B9E7-ED2DD46B6789' { 'Office16_ProjectStdXC2RVL_MAKC2R' }
        '3c0e0ac0-ae70-462e-9c38-5d48e1cd220f' { 'Win 10 RTM IoTUAP Retail' }
        '86a309b8-45f0-4c6c-a637-da4f8fa9a5d7' { 'Win 10 RTM IoTUAPCommercial Volume:MAK' }
        '35cc0c20-01a2-4ec5-8f0e-664e5025008f' { 'Windows Server 12 R2 RTM CoreSystemServer Retail' }
        '2bf74405-283d-46ff-a37e-6828c5a5c7c0' { 'Windows Server Next RTM ServerDatacenterNano Retail' }
        '6301fd75-0488-4b9e-b8c2-ae095b1c86bf' { 'Windows Server Next RTM ServerStandardNano Retail' }
        'E2127526-B60C-43E0-BED1-3C9DC3D5A468' { 'Office16_HomeStudentVNextR_Retail' }
        'A9833863-A86B-4DEA-A034-7FDEB7A6276B' { 'Office16_HomeStudentVNextR_Grace' }
        '8BDA5AA2-F2DB-4124-A513-7BE79DA4E499' { 'Office16_HomeStudentVNextR_Trial' }
        'bf85655c-0b5b-4c9e-b9cf-5a64e0c053b0' { 'ServerCloudStorage 2016 RTM ServerCloudStorage OEM:NONSLP' }
        '36147ad0-32d4-49da-93cd-99cc9c03522b' { 'ServerCloudStorage 2016 RTM ServerCloudStorage OEM:SLP' }
        '13649426-c2a8-4211-9b5c-b5c012a37a80' { 'ServerCloudStorage 2016 RTM ServerCloudStorage Retail' }
        '7b4433f4-b1e7-4788-895a-c45378d38253' { 'ServerCloudStorage 2016 RTM ServerCloudStorage Volume:GVLK' }
        '64e9f058-1cea-4c7b-8f81-6583d6af71dc' { 'Storage Server 2016 RTM ServerStorageStandard OEM:SLP' }
        '47ab5c9d-fd76-470d-8b59-c6cd09ae0324' { 'Storage Server 2016 RTM ServerStorageStandard OEM:NONSLP' }
        '32546532-818a-4b0e-91d2-41aa58b25e40' { 'Storage Server 2016 RTM ServerStorageStandard Retail' }
        '3b324c32-ca8f-432b-bc1f-36258140c556' { 'Storage Server 2016 RTM ServerStorageWorkgroup OEM:SLP' }
        '886ed35a-3eac-4503-9d31-bcac0ad881be' { 'Storage Server 2016 RTM ServerStorageWorkgroup OEM:NONSLP' }
        'dc74cbcb-75e0-4bc9-a706-b4281839e1fe' { 'Storage Server 2016 RTM ServerStorageWorkgroup Retail' }
        '0cd7a57e-c051-4f21-8496-7205beebdcc2' { 'Windows Server Essentials 2016 RTM ServerSolution OEM:NONSLP' }
        'dcf779a7-90ef-4138-a9d2-df5aecfb0fb2' { 'Windows Server Essentials 2016 RTM ServerSolution OEM:NONSLP (MUI locked to zh-CN)' }
        '3f05fe09-7744-473b-8813-8481f4656e7b' { 'Windows Server Essentials 2016 RTM ServerSolution OEM:SLP' }
        '3ab9cd8b-ed58-4b51-846a-f013d7748591' { 'Windows Server Essentials 2016 RTM ServerSolution OEM:SLP (MUI locked to zh-CN)' }
        '2804c327-d727-4813-b230-18c73e11f7cc' { 'Windows Server Essentials 2016 RTM ServerSolution Retail' }
        '64129a84-6d47-48e0-ad16-20232e617f07' { 'Windows Server Essentials 2016 RTM ServerSolution Retail:TB:Eval' }
        '2b5a1b0f-a5ab-4c54-ac2f-a6d94824a283' { 'Windows Server Essentials 2016 RTM ServerSolution Volume:GVLK' }
        '23d0905e-567b-4bde-992d-a1abf86a77d5' { 'Windows Server Essentials 2016 RTM ServerSolution Volume:MAK' }
        'e59d8f3c-05ee-4c5e-9c0f-80200ed0bb54' { 'Windows Server Essentials 2016 RTM ServerSolution VT:IA' }
        'afd55ac6-d0b0-4812-9047-6c756d82bedf' { 'Windows Server 2016 RTM ServerStandard Retail' }
        '21c56779-b449-4d20-adfc-eece0e1ad74b' { 'Windows Server 2016 RTM ServerDatacenter Volume:GVLK' }
        'fea51083-1906-44ed-9072-86af9be7ab9a' { 'Windows Server 2016 RTM ServerDatacenter Volume:MAK' }
        '562634bb-b8d8-43eb-8325-bf63a42c4174' { 'Windows Server 2016 RTM ServerDatacenter VT:IA' }
        'a43f7b89-8023-413a-9f58-b8aec2c04d00' { 'Windows Server 2016 RTM ServerDatacenter OEM:NONSLP' }
        '942efa8f-516f-46d8-8541-b1ee1bce08c6' { 'Windows Server 2016 RTM ServerDatacenter OEM:NONSLP (MUI locked to zh-CN)' }
        'cbf3499f-848e-488b-a165-ac6d7e27439d' { 'Windows Server 2016 RTM ServerDatacenter OEM:SLP' }
        '58448dfb-6ac0-4e06-b491-07f2b657b268' { 'Windows Server 2016 RTM ServerDatacenter OEM:SLP (MUI locked to zh-CN)' }
        '01398239-85ff-487f-9e90-0e3cc5bcc92e' { 'Windows Server 2016 RTM ServerDatacenterEval Retail:TB:Eval' }
        'a2ae7054-d580-4c06-a79b-1662e6f6955c' { 'Windows Server 2016 RTM ServerStandard OEM:NONSLP' }
        '60d99e35-ba21-46e5-abf9-877d5dd815de' { 'Windows Server 2016 RTM ServerStandard OEM:NONSLP (MUI locked to zh-CN)' }
        'f70cf82b-0a95-4f14-a0a9-cb968d337962' { 'Windows Server 2016 RTM ServerStandard OEM:SLP' }
        'f3d100a3-7544-4580-be0b-88d452b4a881' { 'Windows Server 2016 RTM ServerStandard OEM:SLP (MUI locked to zh-CN)' }
        '8c1c5410-9f39-4805-8c9d-63a07706358f' { 'Windows Server 2016 RTM ServerStandard Volume:GVLK' }
        'c0b765fd-6e2e-42f9-80d7-4a7ca0d118cf' { 'Windows Server 2016 RTM ServerStandard Volume:MAK' }
        '179bbfdb-3b18-4fa6-af8f-86f740f28fef' { 'Windows Server 2016 RTM ServerStandard VT:IA' }
        'd839f159-1128-480b-94b6-77fa9943a16a' { 'Windows Server 2016 RTM ServerDatacenter Retail' }
        '9dfa8ec0-7665-4b9d-b2cb-bfc2dc37c9f4' { 'Windows Server 2016 RTM ServerStandardEval Retail:TB:Eval' }
        '2d5a5a60-3040-48bf-beb0-fcd770c20ce0' { 'Win 10 RTM EnterpriseS Volume:GVLK' }
        '9f776d83-7156-45b2-8a5c-359b9c9f22a3' { 'Win 10 RTM EnterpriseSN Volume:GVLK' }
        '3f1afc82-f8ac-4f6c-8005-1d233e606eee' { 'Win 10 RTM ProfessionalEducation Volume:GVLK' }
        '5300b18c-2e33-4dc2-8291-47ffcec746dd' { 'Win 10 RTM ProfessionalEducationN Volume:GVLK' }
        '345a5db0-d94f-4e3b-a0c0-7c42f7bc3ebf' { 'Win 10 RTM ProfessionalEducation Volume:MAK' }
        '550a7080-123a-4c1c-ad73-adebffe64cb0' { 'Win 10 RTM ProfessionalEducationN Volume:MAK' }
        '9297796b-3972-4347-906e-78905da547e2' { 'Windows Server 2016 RTM ServerAzureNano Retail' }
        'b3404d38-04ef-4811-b233-570e528096d1' { 'Windows Server 2016 RTM ServerAzureCor Retail' }
        '1e394594-83b1-40d6-ba96-83fee644ded5' { 'Win 10 RTM EnterpriseSubscription Volume:MAK' }
        '441ca6b5-25ff-43d2-9bd2-106dd21ddaa1' { 'Win 10 RTM EnterpriseSubscriptionN Volume:MAK' }
        'e7a950a2-e548-4f10-bf16-02ec848e0643' { 'Win 10 RTM ProfessionalEducation OEM:DM' }
        '4f3da0d2-271d-4508-ae81-626b60809a38' { 'Win 10 RTM ProfessionalEducation OEM:NONSLP' }
        'd559863d-8e3d-4854-b5ea-8e43ffa8079b' { 'Win 10 RTM ProfessionalEducationN OEM:DM' }
        '58a01bdf-695f-441b-b7c5-bba7b495b894' { 'Win 10 RTM ProfessionalEducationN OEM:NONSLP' }
        '6365275e-368d-46ca-a0ef-fc0404119333' { 'Win 10 RTM ProfessionalWorkstation Retail' }
        'e9a93439-eac5-4d1b-9123-f29bd20cc8fc' { 'Win 10 RTM ProfessionalWorkstationN Retail' }
        '62f0c100-9c53-4e02-b886-a3528ddfe7f6' { 'Win 10 RTM ProfessionalEducation Retail' }
        '13a38698-4a49-4b9e-8e83-98fe51110953' { 'Win 10 RTM ProfessionalEducationN Retail' }
        '2782d615-3249-495b-8260-15a4c2295448' { 'Win 10 RTM EnterpriseS Volume:MAK' }
        '3d1022d8-969f-4222-b54b-327f5a5af4c9' { 'Win 10 RTM EnterpriseSN Volume:MAK' }
        'b47dd250-fd6a-44c8-9217-03aca6e4812e' { 'Win 10 RTM EnterpriseSEval Retail:TB:Eval' }
        '6162e8c2-3c30-46e1-b964-0de603498e2d' { 'Win 10 RTM EnterpriseSNEval Retail:TB:Eval' }
        'f9ee36aa-c068-43f9-8a22-8fb71d07566a' { 'Win 10 RTM EnterpriseS OEM:DM' }
        '706e0cfd-23f4-43bb-a9af-1a492b9f1302' { 'Win 10 RTM EnterpriseS OEM:NONSLP' }
        '3dbf341b-5f6c-4fa7-b936-699dce9e263f' { 'Windows Server 2016 RTM ServerAzureCor Volume:GVLK' }
        'c9b7954b-4a2f-427a-af9a-4a25dc869452' { 'Windows Server 2016 RTM ServerAzureCor VT:IA' }
        '9d0790a8-71df-4851-8f23-9bcd0ccab465' { 'Windows Server 2016 RTM ServerDatacenterCor Retail' }
        '15721ddf-5d40-4108-bbb2-ca005a47a3ba' { 'Windows Server 2016 RTM ServerDatacenterEvalCor Retail:TB:Eval' }
        '16697af0-f804-42f5-a271-10806ffa3f34' { 'Windows Server 2016 RTM ServerStandardCor Retail' }
        'a2d15679-7192-43a9-b4dd-37c32061c07b' { 'Windows Server 2016 RTM ServerStandardEvalCor Retail:TB:Eval' }
        'be42a013-f6cd-4a01-9e02-7da242d5dab7' { 'Win 10 RTM EnterpriseG OEM:DM' }
        '1ca0bfa8-d96b-4815-a732-7756f30c29e2' { 'Win 10 RTM EnterpriseG OEM:NONSLP' }
        'e0b2d383-d112-413f-8a80-97f373a5820c' { 'Win 10 RTM EnterpriseG Volume:GVLK' }
        '5f87a508-7e1c-4fab-9d45-2356c6002081' { 'Win 10 RTM EnterpriseG Volume:MAK' }
        'ecc0774a-aed3-4e1a-b815-2b31781adfea' { 'Win 10 RTM EnterpriseG;EnterpriseGN Volume:CSVLK' }
        'c03ad91f-6809-42f1-95d9-f59ac06e64b7' { 'Win 10 RTM EnterpriseGN OEM:DM' }
        '8d6f6ffe-0c30-40ec-9db2-aad7b23bb6e3' { 'Win 10 RTM EnterpriseGN OEM:NONSLP' }
        'e38454fb-41a4-4f59-a5dc-25080e354730' { 'Win 10 RTM EnterpriseGN Volume:GVLK' }
        '1681ae34-3080-4bfa-a1b5-6d792342e692' { 'Win 10 RTM EnterpriseGN Volume:MAK' }
        '24a0166c-ef8a-436f-bf77-e0ecdf55a41e' { 'Win 10 RTM Cloud OEM:DM' }
        'dcc5f846-873c-4a0b-acfc-e6c54257be79' { 'Win 10 RTM Cloud OEM:NONSLP' }
        'd4ef7282-3d2c-4cf0-9976-8854e64a8d1e' { 'Win 10 RTM Cloud Retail' }
        'f29fabb6-f9f4-4f08-ba72-0d9fdaa561fb' { 'Win 10 RTM CloudN OEM:DM' }
        '0c8be5d6-5b9d-4c6c-8065-eec218df39ed' { 'Win 10 RTM CloudN OEM:NONSLP' }
        'af5c9381-9240-417d-8d35-eb40cd03e484' { 'Win 10 RTM CloudN Retail' }
        'df96023b-dcd9-4be2-afa0-c6c871159ebe' { 'Windows Server Next Beta ServerRdsh Retail' }
        'fa755fe6-6739-40b9-8d84-6d0ea3b6d1ab' { 'Windows Server Next Beta ServerRdsh OEM:NONSLP' }
        '0ad2ac98-7bb9-4201-8d92-312299201369' { 'Windows Server Next Beta ServerRdsh OEM:SLP' }
        'e4db50ea-bda1-4566-b047-0ca50abc6f07' { 'Windows Server Next Beta ServerRdsh Volume:GVLK' }
        '291ece0e-9c38-40ca-a9e1-32cc7ec19507' { 'Windows Server Next Beta ServerRdsh Volume:MAK' }
        '5da22a1c-03e3-44b9-9baa-6cf813821ed3' { 'Win 10 RTM Cloud Volume:MAK' }
        '88dd2204-e92d-40e3-9c35-5c4cc53e6a0a' { 'Win 10 RTM CloudN Volume:MAK' }
        '3502365a-f88a-4ba4-822a-5769d3073b65' { 'Win 10 RTM ProfessionalWorkstation OEM:DM' }
        '95dca82f-385d-4d39-b85b-5c73fa285d6f' { 'Win 10 RTM ProfessionalWorkstation OEM:NONSLP' }
        'eb6d346f-1c60-4643-b960-40ec31596c45' { 'Win 10 RTM ProfessionalWorkstation Retail' }
        '82bbc092-bc50-4e16-8e18-b74fc486aec3' { 'Win 10 RTM ProfessionalWorkstation Volume:GVLK' }
        '721f9237-9341-4453-a661-09e8baa6cca5' { 'Win 10 RTM ProfessionalWorkstation Volume:MAK' }
        '608e9c8c-895c-47ad-a336-4abd5ae221a4' { 'Win 10 RTM ProfessionalWorkstationN OEM:DM' }
        '9252fc78-051d-4eef-b4e1-ae263a885708' { 'Win 10 RTM ProfessionalWorkstationN OEM:NONSLP' }
        '89e87510-ba92-45f6-8329-3afa905e3e83' { 'Win 10 RTM ProfessionalWorkstationN Retail' }
        '4b1571d3-bafb-4b40-8087-a961be2caf65' { 'Win 10 RTM ProfessionalWorkstationN Volume:GVLK' }
        '0e0a4643-943f-4a28-b82f-db752d0d7ec7' { 'Win 10 RTM ProfessionalWorkstationN Volume:MAK' }
        '619af65d-1e24-4cbe-aecf-b00d889fc753' { 'Windows Server Next Beta ServerStandardACor Volume:MAK' }
        '324366bc-d83b-4124-82bc-9c1005d4010e' { 'Windows Server Next Beta ServerDatacenterACor Volume:MAK' }
        '27819f71-d8fd-4d9a-a106-68c4fc3fabb6' { 'ProdKey3 Win 9976 DLA NQR Test Retail:TB:Eval' }
        '32c1c98f-6493-4315-9d4c-dea56620b4d5' { 'Win Next Ultimate OEM:DM' }
        '2a560041-bb61-4dbc-82b2-769a2b5b167a' { 'ProdKey3 Win 9980 OEMAct NQR Test OEM:COA OEM OEM' }
        'd91d8c12-9485-45ab-b950-7e81e6c58095' { 'ProdKey3 Win 9981 DLA NQR Test OEM:NONSLP OEM OEM' }
        '7260bc5d-f92f-4e37-b7f0-d6266c82b7e0' { 'ProdKey3 Win 9982 OEMAct/Preinstall NQR Test OEM:SLP OEM OEM' }
        '2a4403df-877f-4046-8271-db6fb6ec54c8' { 'ProdKey3 Win 9984 DLA/Bypass NQR Test Volume:GVLK Vol Lic MLF' }
        '5dad982e-b500-44a2-bdcc-7ef678e2d375' { 'ProdKey3 Win 9985 DLA CCP NQR Test Retail WAU' }
        '3f0c91d2-f54a-4e3a-8b32-5ba7fa428158' { 'ProdKey3 Win 10001 DLA NQR Test Retail:TB:Promo' }
        '9ae077fe-38bb-4431-a5ad-e99333999fcd' { 'ProdKey3 Win 10002 DLA NQR Test Retail:TB:Sub' }
        'd22353eb-58fc-42ee-bd45-7e29447ec5e2' { 'ProdKey3 Win 10003 ProdAct 500 NQR Test Volume:MAK Vol Lic MLF' }
        '6ff2ebed-3f08-4f44-b9c1-39639e6f6ff5' { 'ProdKey3 Win 10005 DLA NQR Test Retail' }
        '2b66b555-4c8a-4a2a-bbc7-9d88dc2b7a51' { 'ProdKey3 Win 10006 DLA NQR Test Retail:TB:Trial' }
        'ab0b741e-0c08-4242-919b-dbde9e83ef04' { 'Win Next Enterprise Retail' }
        '23e88101-c1e3-42f8-b4ae-6e86254e310a' { 'Win Next Enterprise Retail:TB:Eval' }
        'deecbcaa-3e3c-4e84-93f5-7f6e78ec6af3' { 'Win Next Enterprise Volume:MAK' }
        'cde952c7-2f96-4d9d-8f2b-2d349f64fc51' { 'Windows 10 Enterprise TechPreview' }
        '2d257d22-73bf-4df7-8b82-d7248a116094' { 'Win Next HomePremium Retail' }
        '6f45efa9-4271-4ce8-b9e8-7c58fb98d847' { 'Win Next Professional Retail' }
        '32abc017-5c25-4c88-acf5-137e4e5091bf' { 'Win Next Professional Volume:MAK' }
        'a4383e6b-dada-423d-a43d-f25678429676' { 'Windows 10 Professional TechPreview' }
        'e72830fb-0726-4f21-8fb3-ff8d7daddee0' { 'Win Next Ultimate Retail' }
        '23505d51-32d6-41f0-8ca7-e78ad0f16e71' { 'Win Next Starter Retail' }
        '211b80cc-7f64-482c-89e9-4ba21ff827ad' { 'Win Next StarterN Retail' }
        '15ab1f94-ddf9-46e8-8ce3-a29ccebf320f' { 'Win Next HomeBasic Retail' }
        'd54a0fcb-4c02-495c-b563-fc183646dd64' { 'Win Next HomeBasicN Retail' }
        'fb4bae47-56e2-4168-ad77-c1c49816c3c9' { 'Win Next HomePremiumN Retail' }
        'abee52ee-146b-4fd4-bb8d-14a8dd14b934' { 'Win Next ProfessionalN Retail' }
        '7d78d8d0-913e-4575-9a9c-e05d58f67a7a' { 'Win Next EnterpriseN Retail' }
        '4922fb2a-9866-4d77-9fe6-3206ec449028' { 'Win Next UltimateN Retail' }
        '64192251-81b0-4898-ac63-913cc3edf919' { 'Win Next ProfessionalN Volume:GVLK' }
        'c23947f3-3f2e-401f-a38c-f38fe0ecb0bd' { 'Win Next EnterpriseN Volume:GVLK' }
        '55da3f53-5faa-4d2b-9a0f-e49094d7e942' { '48FWV-TNW4T-CQ6F4-KVGQB-K3D3X' }
        '47305a46-dd4b-469e-bf7d-fd5ceef69c41' { '9XMK8-N3FG8-KH2T4-T9QJM-HPHQX' }
        '442fc1f5-021c-48f7-945b-563e762c95fe' { 'BGN6F-KCBM8-HCFMM-Q744R-W3P7K' }
        'd09822a3-9040-4510-8242-9fc1cfd558d3' { 'NTVV8-X6TR6-CPVQK-KHDV4-9RBDX' }
        'ce7dd669-1230-444f-a107-2c5bd1ba8117' { 'THYVN-T3TXR-Q6WQP-694PR-BVC7K' }
        '583f15fe-fbc2-44de-9cb3-bc196b9a8f0d' { 'NMGYT-GD9DR-298BC-TXK84-4TGVK' }
        '735dc33a-d41d-442b-9b70-61f680da0917' { 'MNKW8-HYCCD-G88JY-283WV-W9FX9' }
        'a1564da7-3cb5-4ac3-b70c-7e6c0c4a8bf1' { 'VKKC6-NQQQH-JW3QX-XRVKX-KJJK9' }
        '80ed1ba0-2fe4-432e-9430-150359e7679b' { 'VV6W8-NF7BJ-FKHGQ-P424D-FHC7K' }
        '326eb516-f215-49c4-9fe2-41065a739d6a' { 'H7XNC-JYM86-7B27X-8MJ9W-TKFX9' }
        '0cc8648c-345c-4576-a335-69f12dcbc9e3' { 'J2ND2-BCW98-8669Y-HPBF3-RDY99' }
        '65d62b33-ca15-4d93-b446-e3473ebc341c' { 'J427X-9NHBK-VRWQQ-B8Y42-T927K' }
        'e35a5d2a-7de6-4266-893e-b9e5bf950dcd' { 'JH8W6-VMNWP-6QBDM-PBP4B-J9FX9' }
        '6fb525d4-9952-4b70-ac7b-ff0aa7e20e41' { 'KD69N-VWMRK-Y9KBG-FCBM3-KF7QX' }
        'b71515d9-89a2-4c60-88c8-656fbcca7f3a' { 'MNMRC-69F8V-2FCXX-GFQVY-BXQ3X' }
        '237f6a98-d028-474d-93ed-226c70a90e68' { 'N3FPV-KQP4R-4M6H6-7Q8TK-HYMDX' }
        'd09822a3-9040-4510-8242-9fc1cfd558d3' { 'NTVV8-X6TR6-CPVQK-KHDV4-9RBDX' }
        '884e5c0c-c968-4182-a7c3-a37d2f716531' { 'P7CCN-72DMB-93C9B-C9PD7-379HK' }
        'f7af7d09-40e4-419c-a49b-eae366689ebd' { 'HNGCC-Y38KG-QVK8D-WMWRK-X86VK' }
        '9971778f-c350-49b2-8453-9126ba534548' { 'P3D2M-NP6MR-JYPD4-WRRT4-W3P7K' }
        'a48938aa-62fa-4966-9d44-9f04da3f72f2' { 'G3KNM-CHG6T-R36X3-9QDG6-8M8K9' }
        '050d1eb7-2345-4eb7-a0b2-0a2c147db37b' { 'RGT4M-CYNRC-2JMPJ-GRVWC-7YMDX' }
        '326eb516-f215-49c4-9fe2-41065a739d6a' { 'H7XNC-JYM86-7B27X-8MJ9W-TKFX9' }
        '050d1eb7-2345-4eb7-a0b2-0a2c147db37b' { 'RGT4M-CYNRC-2JMPJ-GRVWC-7YMDX' }
        '884e5c0c-c968-4182-a7c3-a37d2f716531' { 'P7CCN-72DMB-93C9B-C9PD7-379HK' }
        'b71515d9-89a2-4c60-88c8-656fbcca7f3a' { 'MNMRC-69F8V-2FCXX-GFQVY-BXQ3X' }
        'a72a7c81-fe67-46b5-a69c-7624a1bfe5e9' { '3HDCN-87G3V-FPCDF-C6HTB-79Q3X' }
        'fb91c3ec-ea4d-42f4-a765-2dcd66bb1ece' { 'NXCTR-YXXWC-TK368-HGGTF-8YB99' }
        'ce7dd669-1230-444f-a107-2c5bd1ba8117' { 'THYVN-T3TXR-Q6WQP-694PR-BVC7K' }
        '3116fffc-8eba-4540-bb35-c60cde599bb7' { 'ProdKey3 Win DLA NQR Test-High Limit Retail' }
        '9c4d84ee-befc-4c86-9dde-af7d36267a8a' { 'VQ7FC-RTNC8-RHDFR-8THVR-J633X' }
        'b1c1e105-597d-4aac-9e1d-c7e264c4c91f' { 'XMMNR-TCVTR-DK8GY-KKJ33-3HM99' }
        default { $ProductSku }
    }
}