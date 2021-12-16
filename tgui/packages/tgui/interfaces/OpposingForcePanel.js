import { useBackend, useSharedState } from '../backend';
import { Section, Stack, TextArea, Button, Tabs, Input, Slider, NoticeBox } from '../components';
import { Window } from '../layouts';

export const OpposingForcePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    objectives = [],
    submitted,
    status,
    ss_status,
    can_request_update,
    can_edit,
    backstory,
  } = data;
  return (
    <Window
      title="Opposing Force Panel"
      width={550}
      height={765}
      theme="syndicate">
      <Window.Content>
        <Stack vertical grow>
          <Stack.Item>
            <Section title="Control">
              <Stack>
                <Stack.Item>
                  <Button
                    icon="check"
                    color="good"
                    disabled={submitted}
                    content="Submit Objectives"
                    onClick={() => act('submit')} />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="question"
                    color="orange"
                    disabled={!submitted}
                    content="Ask For Update"
                    onClick={() => act('submit')} />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="wrench"
                    color="blue"
                    disabled={can_edit}
                    content="Request Amendment"
                    onClick={() => act('submit')} />
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
                height="100px"
                value={backstory}
                placeholder="Provide a description of why you want to do bad things. Include specifics such as what lead upto the events that made you want to do bad things, think of it as though you were your character, react appropriately."
                onInput={(e, value) => act('set_backstory', {
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
      </Window.Content>
    </Window>
  );
};


export const OpposingForceObjectives = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    objectives = [],
  } = data;

  const [
    selectedObjectiveID,
    setSelectedObjective,
  ] = useSharedState(context, 'objectives', objectives[0]?.id);

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
                key={objective.id}
                selected={objective.id === selectedObjectiveID}
                onClick={() => setSelectedObjective(objective.id)}>
                <Stack align="center">
                  <Stack.Item width="80%">
                    {objective.title}
                  </Stack.Item>
                  <Stack.Item width="20%">
                    <Button
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
                      step={1}
                      stepPixelSize={1}
                      value={selectedObjective.intensity}
                      minValue={1}
                      maxValue={5}
                      onDrag={(e, value) => act('set_objective_intensity', {
                        objective_ref: selectedObjective.ref,
                        new_intensity_level: value,
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
