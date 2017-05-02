<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EA_Email_Case_From_Agent</fullName>
        <description>EA - Email Case From Agent</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Account__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public_Template/Email_Case_by_Agent</template>
    </alerts>
    <alerts>
        <fullName>EA_Email_Case_From_Customer</fullName>
        <description>EA - Email Case From Customer</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Account__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public_Template/EmailThanksNote</template>
    </alerts>
    <alerts>
        <fullName>EA_Email_Error</fullName>
        <description>EA - Email Error</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Account__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public_Template/Email_Validasi</template>
    </alerts>
    <alerts>
        <fullName>EA_case_undian_berhadiah</fullName>
        <description>EA - case undian berhadiah</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Case_notification_testing</template>
    </alerts>
    <fieldUpdates>
        <fullName>FU_Queues</fullName>
        <field>OwnerId</field>
        <lookupValue>Responded_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>FU - Queues</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Test_Update</fullName>
        <field>Status</field>
        <literalValue>New</literalValue>
        <name>Test Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Testing</fullName>
        <actions>
            <name>EA_case_undian_berhadiah</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Test_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Akun</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Case.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>WF - Email Case From Agent</fullName>
        <actions>
            <name>EA_Email_Case_From_Agent</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Case_Created_By__c</field>
            <operation>equals</operation>
            <value>Agent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Bad_Parameter__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF - Email Case From Customer</fullName>
        <actions>
            <name>EA_Email_Case_From_Customer</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Case_Created_By__c</field>
            <operation>equals</operation>
            <value>Customer</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Bad_Parameter__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF - Email Error</fullName>
        <actions>
            <name>EA_Email_Error</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Bad_Parameter__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF - Quees</fullName>
        <actions>
            <name>FU_Queues</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Bad_Parameter__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>