<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EA_QAN_Request_Approved</fullName>
        <description>EA - QAN - Request Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ET_QAN_Request_Approved</template>
    </alerts>
    <alerts>
        <fullName>EA_QAN_Request_Rejected</fullName>
        <description>EA - QAN - Request Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ET_QAN_Request_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>FU_QAN_Active_TRUE</fullName>
        <field>Active__c</field>
        <literalValue>1</literalValue>
        <name>FU - QAN - Active TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_QAN_Ext_Id</fullName>
        <field>Ext_ID__c</field>
        <formula>QA_Question__c&amp;&apos;-&apos;&amp;User_Agent__c &amp;&apos;-&apos;&amp; Periode__c &amp;&apos;-&apos;&amp; TEXT(Week__c)&amp;&apos;-&apos;&amp; TEXT(Sample_No__c)</formula>
        <name>FU - QAN - Ext Id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_QAN_Share_to_Agent</fullName>
        <field>Share_to_User_Agent__c</field>
        <literalValue>1</literalValue>
        <name>FU - QAN - Share to Agent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_QAN_Share_to_Capt</fullName>
        <field>Share_to_Capt__c</field>
        <literalValue>1</literalValue>
        <name>FU - QAN - Share to Capt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_QAN_Status_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>FU - QAN - Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_QAN_Status_Recall</fullName>
        <field>Status__c</field>
        <literalValue>Draft</literalValue>
        <name>FU - QAN - Status Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_QAN_Status_Waiting</fullName>
        <field>Status__c</field>
        <literalValue>Waiting Approval</literalValue>
        <name>FU - QAN - Status Waiting</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_QAN_Submit_Date</fullName>
        <field>Submit_Date__c</field>
        <formula>NOW()</formula>
        <name>FU - QAN - Submit Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_QAn_Status_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>FU - QAn - Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>WR - QAN - Created</fullName>
        <actions>
            <name>FU_QAN_Ext_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
