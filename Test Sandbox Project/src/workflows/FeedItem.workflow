<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EA_Feed_Item</fullName>
        <ccEmails>taufik.susanto@mii.co.id</ccEmails>
        <description>EA - Feed Item</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ET_Feed_Item</template>
    </alerts>
    <rules>
        <fullName>WR - Feed Item</fullName>
        <actions>
            <name>EA_Feed_Item</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
