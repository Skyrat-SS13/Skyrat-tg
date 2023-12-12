import { map } from 'common/collections';
import { useBackend, useLocalState } from '../backend';
import { Button, Flex, LabeledList, Section, Tabs } from '../components';
import { Window } from '../layouts';

export const PersonalShuttlePurchase = (props) => {
  const [tab, setTab] = useLocalState('tab', 1);
  return (
    <Window title="Personal Shuttle Purchase Console" width={500} height={600}>
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
            Status
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
            Templates
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <PersonalShuttlePurchaseList />}
        {tab === 2 && <PersonalShuttlePurchaseCheckout />}
      </Window.Content>
    </Window>
  );
};

export const PersonalShuttlePurchaseList = (props) => {
  const { act, data } = useBackend();
  const templateObject = data.templates || {};
  const selected = data.selected || {};
  const [selectedTemplateId, setSelectedTemplateId] = useLocalState(
    'templateId',
    Object.keys(templateObject)[0],
  );
  const actualTemplates = templateObject[selectedTemplateId]?.templates || [];
  return (
    <Section>
      <Flex>
        <Flex.Item>
          <Tabs vertical>
            {map((template, templateId) => (
              <Tabs.Tab
                key={templateId}
                selected={selectedTemplateId === templateId}
                onClick={() => setSelectedTemplateId(templateId)}
              >
                {template.port_id}
              </Tabs.Tab>
            ))(templateObject)}
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1} basis={0}>
          {actualTemplates.map((actualTemplate) => {
            const isSelected =
              actualTemplate.shuttle_id === selected.shuttle_id;
            // Whoever made the structure being sent is an asshole
            return (
              <Section
                title={actualTemplate.name}
                level={2}
                key={actualTemplate.shuttle_id}
                buttons={
                  <Button
                    content={isSelected ? 'Selected' : 'Select'}
                    selected={isSelected}
                    onClick={() =>
                      act('select_template', {
                        shuttle_id: actualTemplate.shuttle_id,
                      })
                    }
                  />
                }
              >
                {(!!actualTemplate.description ||
                  !!actualTemplate.credit_cost) && (
                  <LabeledList>
                    {!!actualTemplate.description && (
                      <LabeledList.Item label="Description">
                        {actualTemplate.description}
                      </LabeledList.Item>
                    )}
                    {!!actualTemplate.credit_cost && (
                      <LabeledList.Item label="Cost">
                        {actualTemplate.credit_cost}
                      </LabeledList.Item>
                    )}
                  </LabeledList>
                )}
              </Section>
            );
          })}
        </Flex.Item>
      </Flex>
    </Section>
  );
};

export const PersonalShuttlePurchaseCheckout = (props) => {
  const { act, data } = useBackend();
  const selected = data.selected || {};
  return (
    <Section>
      {selected ? (
        <>
          <Section level={2} title={selected.name}>
            {(!!selected.description || !!selected.selected.credit_cost) && (
              <LabeledList>
                {!!selected.description && (
                  <LabeledList.Item label="Description">
                    {selected.description}
                  </LabeledList.Item>
                )}
                {!!selected.credit_cost && (
                  <LabeledList.Item label="Cost">
                    {selected.credit_cost}
                  </LabeledList.Item>
                )}
              </LabeledList>
            )}
          </Section>
          <Section level={2} title="Status">
            <Button
              content="Purchase"
              color="good"
              onClick={() =>
                act('purchase_shuttle', {
                  shuttle_id: selected.shuttle_id,
                })
              }
            />
          </Section>
        </>
      ) : (
        'No shuttle selected'
      )}
    </Section>
  );
};
