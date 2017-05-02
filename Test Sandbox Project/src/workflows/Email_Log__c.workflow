<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EA_Email_Log_Survey</fullName>
        <ccEmails>Taufik.Susanto@mii.co.id;</ccEmails>
        <ccEmails>Mohamad.Suheri@mii.co.id;</ccEmails>
        <description>EA - Email Log (Survey)</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>test.sftokopedia@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Public_Template/ET_Email_Log_Survey</template>
    </alerts>
    <fieldUpdates>
        <fullName>FU_Status_Email_Log</fullName>
        <field>Status__c</field>
        <literalValue>Send</literalValue>
        <name>FU - Status Email Log</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>WF - Email Log</fullName>
        <actions>
            <name>EA_Email_Log_Survey</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Email_Log__c.Status__c</field>
            <operation>equals</operation>
            <value>Send</value>
        </criteriaItems>
        <criteriaItems>
            <field>Email_Log__c.Ready_To_Send__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>send email survey after insert email log and status = draft</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Email_Log__c.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
