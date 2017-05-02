<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>TOM_Send_approved_email_to_requestor</fullName>
        <description>TOM Send approved email to requestor</description>
        <protected>false</protected>
        <recipients>
            <field>Requestor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TimeOffManager/USTimeOffRequestapproved</template>
    </alerts>
    <alerts>
        <fullName>TOM_Send_rejected_email_to_requestor</fullName>
        <description>TOM Send rejected email to requestor</description>
        <protected>false</protected>
        <recipients>
            <field>Requestor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TimeOffManager/USTimeOffRequestrejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>TOM_Set_Date_Approved</fullName>
        <field>Date_Approved__c</field>
        <formula>now()</formula>
        <name>TOM Set Date Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TOM_Set_Date_Submitted</fullName>
        <field>Date_Submitted__c</field>
        <formula>now()</formula>
        <name>TOM Set Date Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TOM_Set_Status_to_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>TOM Set Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TOM_Set_Status_to_Pending</fullName>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>TOM Set Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TOM_Set_Status_to_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>TOM Set Status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
