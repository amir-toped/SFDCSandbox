<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>FU_Task_End_Call</fullName>
        <field>End_Call__c</field>
        <formula>LastModifiedDate</formula>
        <name>FU - Task - End Call</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_Task_Start_Call</fullName>
        <field>Start_Call__c</field>
        <formula>CreatedDate</formula>
        <name>FU - Task - Start Call</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>WR - Task - Call</fullName>
        <actions>
            <name>FU_Task_End_Call</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>FU_Task_Start_Call</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(Subject,&apos;Call:&apos;) &amp;&amp; ISBLANK(End_Call__c) &amp;&amp; !ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
