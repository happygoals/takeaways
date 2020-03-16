---
layout: default
title: Apply jQuery with .NET Framework
parent: jQuery
permalink: /jquery/jquery-with-dotnet

nav_order: 2
---

# Apply jQuery with .NET Framework
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---


```ruby
<tr>
	<td>Country</td>
	<td>

      <!--
    1) Target the dropdown
    2) Add a handler to each dropdown
    3) The change function must switch the state dropdown
       -->

 <xsl:variable name="countryControlId" select="cirrus:GetNextUniqueControlId()"/>

                            <!-- My Country: '<xsl:value-of select="Country" />'<br /> -->

			<Cirrus:Controls.GenericEditor.FieldEditors.DropDownListFieldEditor runat="server" id="{$countryControlId}" data-id="editcountries{./@_id}" column="Country" GroupKey="{$GroupKey}" style="width:220px;" Value="{$locationXml/Entities/Data/tblLocations/Country}">									
                                <asp:ListItem Text="Select Country" Value="" />
                                <asp:ListItem Text="United States"  Value="United States" />
                                <asp:ListItem Text="Canada"         Value="Canada" />
                                <asp:ListItem Text="Mexico"         Value="Mexico" />
			</Cirrus:Controls.GenericEditor.FieldEditors.DropDownListFieldEditor>
			<Cirrus:Controls.Validators.HighlightValidators.HighlightRequiredValidator runat="server" enableClientScript="true" Display="Dynamic" errorMessage="Country is required" controlToValidate="{$countryControlId}" validationGroup="{$ValidationGroup}" SetFocusOnError="true"/>

                            <script>

                                $(document).ready(function() {

                                    // 1) retrieve the dropdown from above
                                    var myCountriesDropdown = $('*[data-id="editcountries<xsl:value-of select="./@_id" />"]');

                                    // 2) Add change handler to this dropdown
                                    $(myCountriesDropdown).change(function() {
                                        
                                        // Get pointer to the state dropdown
                                        var myStatesDropdown = $('*[data-id="editstates<xsl:value-of select="./@_id" />"]');

                                        // Retrieve the country selection that the user made
                                        var SelectedCountry = $(myCountriesDropdown).val();

                                        if (SelectedCountry === '')
                                        {
                                            console.log('No Country selected!');
                                        }
                                        else 
                                        {
                                            // 3) Change function changes the state dropdown                                    
                                            var StatesOrRegionsForCountry = Regions[SelectedCountry];

                                            // Clear the dropdown of all items
                                            $(myStatesDropdown).empty();

                                            StatesOrRegionsForCountry.forEach(function(item, index) {
                                                // Add this item into the dropdown
                                                $(myStatesDropdown)
                                                        .append($("<option></option>")
                                                        .attr('value',item.Abbreviation)
                                                        .text(item.Region))
                                            });
                                        }
                                    });

                                });

                            </script>
						</td>
					</tr>					

					<tr>
						<td>State</td>
						<td>
								<xsl:variable name="stateControlId" select="cirrus:GetNextUniqueControlId()"/>
								<Cirrus:Controls.GenericEditor.FieldEditors.DropDownListFieldEditor runat="server" id="{$stateControlId}" data-id="editstates{./@_id}" column="State" GroupKey="{$GroupKey}" style="width:220px;" Value="{$locationXml/Entities/Data/tblLocations/State}">
                                    <xsl:choose>
                                        <xsl:when test="Country = 'Mexico'">
                                            <xsl:call-template name="MX_States_Selector" />
                                        </xsl:when>
                                        <xsl:when test="Country = 'Canada'">
                                            <xsl:call-template name="CA_States_Selector" />
                                        </xsl:when>
                                        <xsl:when test="Country = 'United States'">
                                            <xsl:call-template name="US_States_Selector" />
                                        </xsl:when>                                        
                                        <xsl:otherwise>

                                        </xsl:otherwise>
                                    </xsl:choose>
									
			</Cirrus:Controls.GenericEditor.FieldEditors.DropDownListFieldEditor>
			<Cirrus:Controls.Validators.HighlightValidators.HighlightRequiredValidator runat="server" enableClientScript="true" Display="Dynamic" errorMessage="State is required" controlToValidate="{$stateControlId}" validationGroup="{$ValidationGroup}" SetFocusOnError="true"/>
						</td>
					</tr>
```

C#: UserAccountsExtensions.cs 
```ruby
 private string CreateMemberHTMLEmailBody(CirrusABS.Entities.Security.Authentication.User user, string Discriminator, List<CirrusABS.Logic.Controls.GenericEditor.IFieldEditorControl> fieldeditors, out string returnUrl)
        {
            returnUrl = "~/";           
            string title = Discriminator == "51" ? "Vendor" : "Member";             
            StringBuilder html = new StringBuilder();
            StringBuilder subhtml = new StringBuilder();
            html.Append("<table border=\"0\" cellspacing=\"2\" cellpadding=\"3\" width=\"650\">");
            html.Append(string.Format("<caption><h2>{0} IWDC {1} User</h2></caption>", user == null ? "Create New" : "Update", title));            
            CirrusABS.Entities.Modules.Locations.Location locn = user == null ? null : CirrusABS.Data.Manager.PersistenceManager.LoadObject<CirrusABS.Entities.Modules.Locations.Location>((int)user.GetEntityField("LocationId"));

            foreach (var field in fieldeditors)
            {
                switch (field.Column)
                {
                    case "LastUpdate":                        
                        html.Append(FormatHTMLEncode(false, "<tr><td align=\"right\" width=\"30%\">LAST UPDATE:</td><td>{0}</td></tr>", field.Value.Trim()));
                        break;
                    case "username":
                        html.Append(FormatHTMLEncode(user == null || field.Value.Trim().ToLower() != user.Username.ToLower(), "<tr><td align=\"right\" width=\"30%\">EMAIL*:</td><td>{0}</td></tr>", field.Value.Trim()));
                        break;
                    case "isEnabled":
                        bool ischecked = (field as CirrusABS.Presentation.Controls.GenericEditor.FieldEditors.BooleanRadioButtonFieldEditor).Checked;
                        html.Append(FormatHTMLEncode(user == null || ischecked != user.IsEnabled, "<tr><td align=\"right\">ACTIVATION*:</td><td>{0}</td></tr>", ischecked ? "Active" : "Disabled"));
                        break;
                    case "loginFirstname": 
                        html.Append(FormatHTMLEncode(user == null || field.Value.Trim().ToLower() != user.FirstName.ToLower(), "<tr><td align=\"right\">FIRST NAME*:</td><td>{0}</td></tr>", field.Value.Trim()));
                        break;
                    case "loginLastname":
                        html.Append(FormatHTMLEncode(user == null || field.Value.Trim().ToLower() != user.LastName.ToLower(), "<tr><td align=\"right\">LAST NAME*:</td><td>{0}</td></tr>", field.Value.Trim()));
                        break;
                    case "Position":
                        html.Append(FormatHTMLEncode(user == null || field.Value.Trim().ToLower() != user.Position.ToLower(), "<tr><td align=\"right\">TITLE/POSITION*:</td><td>{0}</td></tr>", field.Value.Trim()));
                        break;
                    case "BusinessRole":
                        html.Append(FormatHTMLEncode(user == null || field.Value.Trim().ToLower() != user.GetEntityField("BusinessRole").ToString().ToLower(), "<tr><td align=\"right\">ROLE*:</td><td>{0}</td></tr>", field.Value));
                        break;
                    case "Phone":
                        var phone = field.Value.Trim();
                        html.Append(FormatHTMLEncode(user == null || field.Value.Trim() != user.Phone, "<tr><td align=\"right\">PHONE NUMBER*:</td><td>{0}</td></tr>", string.IsNullOrEmpty(phone) || phone.Length != 10 ? field.Value : string.Format("{0:###-###-####}", long.Parse(phone))));
                        break;
                    case "UserRole":                        
                        bool isadmin = (field as CirrusABS.Presentation.Controls.GenericEditor.FieldEditors.BooleanRadioButtonFieldEditor).Checked;
                        bool nowadmin = user == null ? false : IsUserAdmin(user.MasterRecordId, locn.MasterRecordId);
                        subhtml.Append(FormatHTMLEncode(user == null || isadmin != nowadmin, "<tr><td align=\"right\">USER ROLE*:</td><td>{0}</td></tr>", (field as CirrusABS.Presentation.Controls.GenericEditor.FieldEditors.BooleanRadioButtonFieldEditor).Checked ? string.Format("{0} Admin", title) : string.Format("{0} User", title)));
                        break;
                    case "Location":
                        var mlocn = (field as CirrusABS.Presentation.Controls.GenericEditor.FieldEditors.DropDownListFieldEditor).SelectedItem;                        
                        html.Append(FormatHTMLEncode(user == null || int.Parse(mlocn.Value) != locn.Id, "<tr><td align=\"right\">COMPANY*:</td><td>{0}</td></tr>", mlocn.Text));
                        break;
                    case "LocationId":
                        var vlocn = CirrusABS.Data.Manager.PersistenceManager.LoadObject<CirrusABS.Entities.Modules.Locations.Location>(int.Parse(field.Value));
                        html.Append(FormatHTMLEncode(user == null || int.Parse(field.Value) != vlocn.Id, "<tr><td align=\"right\">COMPANY*:</td><td>{0}</td></tr>", vlocn == null ? "Unknown" : vlocn.Name));
                        break;
                    case "Address":
                        html.Append(FormatHTMLEncode(user == null || field.Value.Trim().ToLower() != locn.Address.ToLower(), "<tr><td align=\"right\">COMPANY ADDRESS*:</td><td>{0}</td></tr>", field.Value.Trim()));
                        break;
                    case "City":
                        html.Append(FormatHTMLEncode(user == null || field.Value.Trim().ToLower() != locn.City.ToLower(), "<tr><td align=\"right\">COMPANY CITY*:</td><td>{0}</td></tr>", field.Value.Trim()));
                        break;
                    case "State":
                    //  var state = (field as CirrusABS.Presentation.Controls.GenericEditor.FieldEditors.DropDownListFieldEditor).SelectedItem;
                    //  html.Append(FormatHTMLEncode(user == null || state.Value != locn.State, "<tr><td align=\"right\">COMPANY STATE*:</td><td>{0}</td></tr>", state.Text));
                    //  break;
                    case "Country":
                        var country = (field as CirrusABS.Presentation.Controls.GenericEditor.FieldEditors.DropDownListFieldEditor).SelectedItem;
                        subhtml.Append(FormatHTMLEncode(user == null || country.Value != locn.GetEntityField("Country").ToString(), "<tr><td align=\"right\">COMPANY COUNTRY*:</td><td>{0}</td></tr>", country.Text));
                        break;
                    case "ZipCode":
                        subhtml.Append(FormatHTMLEncode(user == null || field.Value.Trim() != locn.Zip, "<tr><td align=\"right\">COMPANY ZIP CODE*:</td><td>{0}</td></tr>", field.Value.Trim()));
                        break;
                    case "IsPricingGroup":
                        bool ispricing = (field as CirrusABS.Presentation.Controls.GenericEditor.FieldEditors.CheckBoxFieldEditor).Checked;
                        subhtml.Append(FormatHTMLEncode(user == null || ispricing != (bool)user.GetEntityField("IsPricingGroup"), "<tr><td align=\"right\">PRICING GROUP*:</td><td>{0}</td></tr>",  ispricing.ToString()));
                        break;
                    case "DistributionList":
                        string ischanged = user == null || CompareDistributionLists(user, field as CirrusABS.Presentation.Controls.GenericEditor.FieldEditors.CheckBoxListFieldEditor) ? "*" : string.Empty;
                        subhtml.Append(string.Format("<tr><td align=\"right\" valign=\"top\">DISTRIBUTION LIST{0}:</td><td>{1}</td></tr>", ischanged, GetDistributionLists(field)));
                        break;
                    case "VendorDistributionList":
                        string ismodified = user == null || CompareVendorDistributionLists(user, field as CirrusABS.Presentation.Controls.GenericEditor.FieldEditors.CheckBoxListFieldEditor) ? "*" : string.Empty;
                        subhtml.Append(string.Format("<tr><td align=\"right\" valign=\"top\">DISTRIBUTION LIST{0}:</td><td>{1}</td></tr>", ismodified, GetDistributionLists(field)));
                        break;
                    case "Comments":
                        subhtml.Append(FormatHTMLEncode(false, "<tr><td align=\"right\" valign=\"top\">COMMENTS:</td><td>{0}</td></tr>", field.Value));
                        break;
                    case "ReturnUrl":
                        returnUrl = field.Value;
                        break;
                }
            }

            var editStateDropdownValue = this.Container.Page.Request.Form["state" + (user == null ? 0 : user.Id)];
            html.Append(FormatHTMLEncode(user == null || editStateDropdownValue.ToString().Split(';')[0] != locn.State, "<tr><td align=\"right\">COMPANY STATE*:</td><td>{0}</td></tr>", editStateDropdownValue.ToString().Split(';')[1]));
            html.Append(subhtml);

            html.Append("</table>");
            html.Append("<p><b>NOTE:</b> Fields marked with <b>*</b> have been modified by the user.</p>");
            return html.ToString(); 
        }
```

## Reference for jQuery
* [Add options to a DropDownList using jQuery](https://stackoverflow.com/questions/317095/how-do-i-add-options-to-a-dropdownlist-using-jquery)
* [Add options to a drop-down list using jQuery](https://www.w3resource.com/jquery-exercises/part1/jquery-practical-exercise-31.php)
* [Clear dropdownlist with JQuery](https://stackoverflow.com/questions/9909326/clear-dropdownlist-with-jquery)
* [Control.ClientID Property](https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.control.clientid?view=netframework-3.5#System_Web_UI_Control_ClientID)
* [How to get the data-id attribute](https://stackoverflow.com/questions/5309926/how-to-get-the-data-id-attribute)
* [How to set a default value for DropDownList in asp.net](https://asp-net-example.blogspot.com/2013/12/aspnet-example-dropdownlist-default.html)

## Reference for C#
* [JavaScript String split() Method](https://www.w3schools.com/jsref/jsref_split.asp)
* [StringBuilder.Append Method](https://docs.microsoft.com/en-us/dotnet/api/system.text.stringbuilder.append?view=netframework-4.8)
