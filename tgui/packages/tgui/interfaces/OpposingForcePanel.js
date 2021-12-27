import { toFixed } from 'common/math';
import { useBackend, useLocalState } from '../backend';
import { Section, Stack, TextArea, Button, Tabs, Input, Slider, NoticeBox, LabeledList } from '../components';
import { Window } from '../layouts';

export const OpposingForcePanel = (props, context) => {
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  const { act, data } = useBackend(context);
  const {
    admin_mode,
  } = data;
  return (
    <Window
      title="Opposing Force Panel"
      width={585}
      height={805}
      theme="syndicate">
      <Window.Content>
        <Tabs>
          <Tabs.Tab
            selected={tab === 1}
            onClick={() => setTab(1)}>
            Summary
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 2}
            onClick={() => setTab(2)}>
            Equipment
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 3}
            onClick={() => setTab(3)}>
            Admin Chat
          </Tabs.Tab>
          {admin_mode && (
            <Tabs.Tab
              selected={tab === 4}
              onClick={() => setTab(4)}>
              Admin Control
            </Tabs.Tab>
          )}
        </Tabs>
        {tab === 1 && (
          <OpposingForceTab />
        )}
        {tab === 2 && (
          <EquipmentTab />
        )}
        {tab === 3 && (
          <AdminChatTab />
        )}
        {admin_mode && (
          tab === 4 && (
            <AdminTab />
          )
        )}
      </Window.Content>
    </Window>
  );
};

export const OpposingForceTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    admin_mode,
    creator_ckey,
    objectives = [],
    can_submit,
    status,
    ss_status,
    can_request_update,
    can_request_update_cooldown,
    can_edit,
    backstory,
  } = data;
  return (
    <Stack vertical grow>
      <Stack.Item>
        <Section title="Control">
          <Stack>
            <Stack.Item>
              <Button
                icon="check"
                color="good"
                disabled={!can_submit}
                content="Submit Objectives"
                onClick={() => act('submit')} />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="question"
                color="orange"
                disabled={!can_request_update}
                content="Ask For Update"
                onClick={() => act('request_update')} />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="wrench"
                color="blue"
                disabled={can_edit}
                content="Request Changes"
                onClick={() => act('request_changes')} />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="trash"
                color="bad"
                content="Delete Application"
                onClick={() => act('close_application')} />
            </Stack.Item>
          </Stack>
          <NoticeBox color="orange" mt={2}>
            {status}
          </NoticeBox>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Backstory">
          <TextArea
            disabled={!can_edit}
            height="100px"
            value={backstory}
            placeholder="Provide a description of why you want to do bad things. Include specifics such as what lead upto the events that made you want to do bad things, think of it as though you were your character, react appropriately."
            onInput={(_e, value) => act('set_backstory', {
              backstory: value,
            })} />
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Objectives"
          buttons={(
            <Button
              icon="plus"
              content="Add Objective"
              onClick={() => act('add_objective')} />
          )}>
          { !!objectives.length && (
            <OpposingForceObjectives />
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
};


export const OpposingForceObjectives = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    objectives = [],
    can_edit,
    admin_mode,
  } = data;

  const [
    selectedObjectiveID,
    setSelectedObjective,
  ] = useLocalState(context, 'objectives', objectives[0]?.id);

  const selectedObjective = objectives.find(objective => {
    return objective.id === selectedObjectiveID;
  });

  return (
    <Stack vertical grow>
      { objectives.length > 0 && (
        <Stack.Item>
          <Tabs fill>
            {objectives.map(objective => (
              <Tabs.Tab
                width="25%"
                disabled={!can_edit}
                key={objective.id}
                selected={objective.id === selectedObjectiveID}
                onClick={() => setSelectedObjective(objective.id)}>
                <Stack align="center">
                  <Stack.Item width="80%">
                    {objective.title ? objective.title : 'Blank Objective'}
                  </Stack.Item>
                  <Stack.Item width="20%">
                    <Button
                      disabled={!can_edit}
                      height="90%"
                      icon="minus"
                      color="bad"
                      textAlign="center"
                      tooltip="Remove objective"
                      onClick={() => act('remove_objective', {
                        objective_ref: objective.ref })}
                    />
                  </Stack.Item>
                </Stack>
              </Tabs.Tab>
            ))}
          </Tabs>
        </Stack.Item>
      )}
      { selectedObjective ? (
        <Stack.Item>
          <Stack vertical>
            <Stack.Item>
              <Stack.Item>
                <Stack vertical>
                  <Stack.Item >
                    Title
                  </Stack.Item>
                  <Stack.Item>
                    <Input
                      disabled={!can_edit}
                      width="100%"
                      placeholder="blank objective"
                      value={selectedObjective.title}
                      onChange={(e, value) => act('set_objective_title', {
                        objective_ref: selectedObjective.ref,
                        title: value,
                      })} />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item>
                <Stack vertical mt={2}>
                  <Stack.Item >
                    Intensity: {selectedObjective.text_intensity}
                  </Stack.Item>
                  <Stack.Item>
                    <Slider
                      disabled={!can_edit}
                      step={0.1}
                      stepPixelSize={0.1}
                      value={selectedObjective.intensity}
                      minValue={100}
                      maxValue={500}
                      onDrag={(e, value) => act('set_objective_intensity', {
                        objective_ref: selectedObjective.ref,
                        new_intensity_level: toFixed(value),
                      })} />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item>
                <Stack vertical mt={2}>
                  <Stack.Item >
                    Description
                  </Stack.Item>
                  <Stack.Item>
                    <TextArea
                      fluid
                      disabled={!can_edit}
                      height="85px"
                      value={selectedObjective.description}
                      placeholder="Input objective description here, be descriptive about what you want to do."
                      onInput={(e, value) => act('set_objective_description', {
                        objective_ref: selectedObjective.ref,
                        new_desciprtion: value,
                      })} />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item>
                <Stack vertical mt={2}>
                  <Stack.Item>
                    Justification
                  </Stack.Item>
                  <Stack.Item>
                    <TextArea
                      disabled={!can_edit}
                      height="85px"
                      placeholder="Input objective justification here, ensure you have a good reason for this objective!"
                      value={selectedObjective.justification}
                      onInput={(e, value) => act('set_objective_justification', {
                        objective_ref: selectedObjective.ref,
                        new_justification: value,
                      })} />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item mt={2}>
                <NoticeBox color={selectedObjective.status ? "good" : "bad"}>
                  {selectedObjective.status ? "Objective has been approved!" : "Objective has not been approved yet. Do not attempt to complete it."}
                </NoticeBox>
              </Stack.Item>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      ) : (
        <Stack.Item>
          No objectives selected.
        </Stack.Item>
      )}
    </Stack>
  );
};

export const AdminTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    request_updates_muted,
    approved,
    denied,
    creator_ckey,
    objectives = [],
    can_edit,
    backstory,
  } = data;
  return (
    <Stack vertical grow>
      <Stack.Item>
        <Section title="Admin Control">
          <Stack>
            <Stack.Item>
              <Button
                icon="check"
                color="good"
                disabled={approved}
                content="Approve"
                onClick={() => act('approve')} />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="times"
                color="red"
                disabled={denied}
                content="Deny"
                onClick={() => act('deny')} />
            </Stack.Item>
            <Stack.Item>
              {request_updates_muted ? (
                <Button
                  icon="volume-mute"
                  color="red"
                  content="Mute Help Requests"
                  onClick={() => act('mute_request_helps')} />
              ) : (
                <Button
                  icon="volume-up"
                  color="green"
                  content="Unmute Help Requests"
                  onClick={() => act('mute_request_updates')} />
              )}
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Backstory">
          {backstory}
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Objectives">
          {objectives.map((objective, index) => (
            <Section
              title={index + 1 + ". " + objective.title} key={objective.id}
              buttons={(
                <Button
                  icon="check"
                  color="good"
                  disabled={!can_edit}
                  content="Approve"
                  onClick={() => act('approve_objective', {
                    objective_ref: selectedObjective.ref,
                  })} />
              )}>
              <LabeledList key={objective.id}>
                <LabeledList.Item label="Description">
                  {objective.description}
                </LabeledList.Item>
                <LabeledList.Item label="Justification">
                  {objective.justification}
                </LabeledList.Item>
                <LabeledList.Item label="Intensity">
                  {objective.text_intensity}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          ))}
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const AdminChatTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    equipment = [],
  } = data;
  return (
    <Stack vertical grow>
      <Stack.Item>
        <Section title="Admin Control">
          <NoticeBox color="good">
            Work in progress! Check back later.
          </NoticeBox>
        </Section>
      </Stack.Item>
    </Stack>
  );
};



export const EquipmentTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    equipment = [],
  } = data;
  return (
    <Stack vertical grow>
      <Stack.Item>
        <Section title="Admin Control">
          <NoticeBox color="good">
            Work in progress! Check back later.
          </NoticeBox>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
