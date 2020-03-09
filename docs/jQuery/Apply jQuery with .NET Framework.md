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

## Reference
* [Add options to a DropDownList using jQuery](https://stackoverflow.com/questions/317095/how-do-i-add-options-to-a-dropdownlist-using-jquery)
* [Add options to a drop-down list using jQuery](https://www.w3resource.com/jquery-exercises/part1/jquery-practical-exercise-31.php)
* [Clear dropdownlist with JQuery](https://stackoverflow.com/questions/9909326/clear-dropdownlist-with-jquery)
* [Control.ClientID Property](https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.control.clientid?view=netframework-3.5#System_Web_UI_Control_ClientID)
* [How to set a default value for DropDownList in asp.net](https://asp-net-example.blogspot.com/2013/12/aspnet-example-dropdownlist-default.html)
