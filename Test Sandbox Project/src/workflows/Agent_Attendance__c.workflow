<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EA_AgAtt_Late</fullName>
        <description>EA - AgAtt - Late</description>
        <protected>false</protected>
        <recipients>
            <field>Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ET_AgAtt_Late</template>
    </alerts>
    <rules>
        <fullName>WR - AgAtt - Late</fullName>
        <actions>
            <name>EA_AgAtt_Late</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Agent_Attendance__c.Login_Status__c</field>
            <operation>equals</operation>
            <value>LATE</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
