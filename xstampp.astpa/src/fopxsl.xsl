<?xml version="1.0" encoding="UTF-8"?>
<!--
  Copyright (C) 2018 Jaqueline Patzek, Patrick Wickenhäuser,Lukas Balzer StuPro 2013 / 2014
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
  
  Contributors:
      Jaqueline Patzek, Patrick Wickenhäuser,Lukas Balzer  - initial API and implementation
-->
<xsl:stylesheet version="1.0"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- author: Jaqueline Patzek, Patrick Wickenhäuser,Lukas Balzer -->
	<!-- StuPro 2013 / 2014 -->

	<!-- Note: This xsl gathers all the informations from the .haz-file -->
	<!-- which is generated by the "prepareForExport()"-Command in the -->
	<!-- ViewContainer.java -->
	<xsl:import href="ucaTableTemp.xsl" />
    <xsl:import href="fopSystemDescription.xsl" />
	<xsl:param name="page.layout" select="A4" />
	<xsl:param name="page.title" select="''" />

	<xsl:template match="/*">
		<fo:root>
			<!-- Page layout -->
			<fo:layout-master-set>
				<xsl:call-template name="layout" />
			</fo:layout-master-set>

			<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
			<!-- ++++++++++++++++++++ START OF PDF ++++++++++++++++++++ -->
			<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

			<!-- +++++ Front-Page +++++ -->
			<fo:page-sequence>
				<xsl:attribute name="master-reference"><xsl:value-of select="$page.layout" /></xsl:attribute>
				<fo:flow flow-name="xsl-region-body">
					<fo:block intrusion-displace="line">
						<fo:table space-after="30pt">
							<fo:table-column column-number="1" column-width="100%"
								border-style="none" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell padding="10px" text-align="center">
										<fo:block font-size="18pt">
											A-STPA-Report
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell background-color="#1A277A"
										padding="10px" text-align="center">
										<xsl:call-template name="headTheme" />
										<fo:block font-size="24pt" color="#FFFFFF">
											<xsl:call-template name="fontTheme" />
											<xsl:value-of select="projectdata/projectName" />
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:if test="exportinformation/logoPath">
									<fo:table-row>
										<fo:table-cell padding="15px" text-align="center">
											<fo:block>
												<fo:external-graphic content-width="100mm">
													<xsl:attribute name="src">
												<!-- Path of the logo via haz-file -->
												<xsl:value-of select="exportinformation/logoPath" />
												</xsl:attribute>
												</fo:external-graphic>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if>
							</fo:table-body>
						</fo:table>
					</fo:block>

					<!-- Main-data for the front-page -->
                    <xsl:call-template name="SystemDescription"/>
				</fo:flow>
			</fo:page-sequence>

			<!-- +++++ Common Page content +++++ -->
			<fo:page-sequence white-space-collapse="true" id="total">
				<xsl:attribute name="master-reference"><xsl:value-of select="$page.layout" /></xsl:attribute>

				<!-- Header-Block -->
				<fo:static-content flow-name="xsl-region-before">
					<xsl:call-template name="astpaHead">
						<xsl:with-param name="pdfTitle" select="$page.title" />
					</xsl:call-template>
				</fo:static-content>

				<!-- Footer-Block -->
				<fo:static-content flow-name="xsl-region-after">
					<xsl:call-template name="astpaFooter" />
				</fo:static-content>

				<fo:flow flow-name="xsl-region-body">
					<!-- *************** Accidents *************** -->
					<fo:block>
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Accidents
						</fo:block>
						<!-- Accidents-Table-Template -->
						<xsl:call-template name="accidentsTable" />
					</fo:block>


					<!-- *************** Hazard table *************** -->
					<fo:block>
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Hazards
						</fo:block>
						<!-- Hazard-Table-Template -->
						<xsl:call-template name="hazardTable" />
					</fo:block>

					<!-- *************** Safety Constraints table *************** -->
					<fo:block>
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Safety Constraints
						</fo:block>
						<!-- Safety Constraint-Table-Template -->
						<xsl:call-template name="safetyConstraintsTable" />
					</fo:block>

					<!-- *************** System Goals table *************** -->
					<fo:block>
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							System Goals
						</fo:block>
						<!-- System Goals-Table-Template -->
						<xsl:call-template name="systemGoalsTable" />
					</fo:block>

					<!-- *************** Design Requirements table *************** -->
					<fo:block page-break-after="always">
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Design Requirements
						</fo:block>
						<!-- Design Requirements-Table-Template -->
						<xsl:call-template name="designRequirementsTable" />
					</fo:block>

					<!-- *************** Control Structure Diagram *************** -->
					<fo:block page-break-after="always">
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Control Structure Diagram
						</fo:block>
						<fo:block>
							<xsl:if test="exportinformation/csImagePath">
								<xsl:choose>
									<xsl:when test="$page.layout = 'A4'">
										<fo:external-graphic
											inline-progression-dimension.maximum="100%" height="29.7cm"
											width="16cm" content-height="scale-down-to-fit"
											content-width="scale-down-to-fit">
											<xsl:attribute name="src">
										<!-- Path of the Control Structure via haz-file -->
										<xsl:value-of select="exportinformation/csImagePath" />
										</xsl:attribute>
										</fo:external-graphic>
									</xsl:when>
									<xsl:otherwise>
										<fo:external-graphic
											inline-progression-dimension.maximum="100%" height="16cm"
											width="29.7cm" content-height="scale-down-to-fit"
											content-width="scale-down-to-fit">
											<xsl:attribute name="src">
										<!-- Path of the Control Structure via haz-file -->
										<xsl:value-of select="exportinformation/csImagePath" />
										</xsl:attribute>
										</fo:external-graphic>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</fo:block>
					</fo:block>


					<!-- *************** Control Actions table *************** -->
					<fo:block>
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Control Actions
						</fo:block>
						<!-- Control Actions-Table-Template -->
						<xsl:call-template name="controlActionsTable" />
					</fo:block>

					<!-- *************** Unsafe Control Actions *************** -->
					<fo:block>
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Unsafe Control Actions
						</fo:block>
						<!-- Unsafe Control Actions-Table-Template -->
						<xsl:call-template name="ucaTable" />
					</fo:block>

					<!-- *************** Corresponding Safety Constraints *************** -->
					<fo:block page-break-after="always">
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Corresponding Safety
							Constraints
						</fo:block>
						<!-- Unsafe Control Actions-Table-Template -->
						<xsl:call-template name="correspondingSafetyConstraintsTable" />
					</fo:block>

					<!-- *************** Design Requirements Step 1 *************** -->
					<fo:block page-break-after="always">
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Design Requirements Step 1
						</fo:block>
						<!-- Unsafe Control Actions-Table-Template -->
						<xsl:call-template name="designRequirementsStep1Table" />
					</fo:block>

					<!-- *************** Control Structure Diagram with Process Model *************** -->
					<fo:block page-break-after="always">

						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Control Structure Diagram
							with Process Model
						</fo:block>

						<xsl:choose>
							<xsl:when test="$page.layout = 'A4'">
								<fo:external-graphic
									inline-progression-dimension.maximum="100%" height="29.7cm"
									width="16cm" content-height="scale-down-to-fit" content-width="scale-down-to-fit">
									<xsl:attribute name="src">
										<!-- Path of the Control Structure via haz-file -->
										<xsl:value-of select="exportinformation/cspmImagePath" />
										</xsl:attribute>
								</fo:external-graphic>
							</xsl:when>
							<xsl:otherwise>
								<fo:external-graphic
									inline-progression-dimension.maximum="100%" height="16cm"
									width="29.7cm" content-height="scale-down-to-fit"
									content-width="scale-down-to-fit">
									<xsl:attribute name="src">
										<!-- Path of the Control Structure via haz-file -->
										<xsl:value-of select="exportinformation/cspmImagePath" />
										</xsl:attribute>
								</fo:external-graphic>
							</xsl:otherwise>
						</xsl:choose>
					</fo:block>

					<!-- *************** Causal Factors Table *************** -->
					<fo:block>
						<fo:block font-size="24pt" space-after="5pt"
							page-break-after="avoid">
							Causal Factors
						</fo:block>
						<!-- Causal Factors-Table-Template -->
						<xsl:call-template name="causalFactorsTable" />
					</fo:block>

                    <!-- *************** Design Requirements Step 2 *************** -->
                    <fo:block page-break-after="always">
                        <fo:block font-size="24pt" space-after="5pt"
                            page-break-after="avoid">
                            Design Requirements Step 2
                        </fo:block>
                        <!-- Unsafe Control Actions-Table-Template -->
                        <xsl:call-template name="designRequirementsStep2Table" />
                    </fo:block>

                    <fo:block page-break-after="always">
                        <fo:block font-size="24pt" space-after="5pt"
                            page-break-after="avoid">
                            Glossary
                        </fo:block>
                        <xsl:call-template name="glossary" />
                    </fo:block>
				</fo:flow>
			</fo:page-sequence>

			<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
			<!-- +++++++++++++++++++++ END OF PDF +++++++++++++++++++++ -->
			<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

		</fo:root>
	</xsl:template>



</xsl:stylesheet>

