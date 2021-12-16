import { useBackend } from '../backend';
import { Section, Stack, TextArea, Button, Divider, Tabs, Tooltip, RoundGauge, NumberInput } from '../components';
import { Window } from '../layouts';

export const OpposingForcePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    objectives = [],
    backstory,
  } = data;
  return (
    <Window
      title="Opposing Force Panel"
      width={550}
      height={650}>
      <Window.Content>
        <Stack vertical grow>
          <Stack.Item>
            <Section title="Backstory">
              <TextArea
                height="100px"
                value={backstory}
                placeholder={backstory}
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
      <Divider />
      { objectives.length > 0 && (
        <Stack.Item>
          <Tabs fill>
            {objectives.map(objective => (
              <Tabs.Tab
                width="20%"
                key={objective.id}
                selected={objective.id === selectedObjectiveID}
                onClick={() => setSelectedObjective(objective.id)}>
                <Stack align="center">
                  <Stack.Item width="80%">
                    Objective: {objective.id}
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
              <Stack width="100%">
                <Stack.Item mr={3}>
                  <Stack vertical width="225px">
                    <Stack.Item >
                      Objective Description
                    </Stack.Item>
                    <Stack.Item>
                      <TextArea
                        fluid
                        height="85px"
                        value={selectedObjective.description}
                        onInput={(e, value) => act('set_objective_description', {
                          objective_ref: objective.ref,
                          new_desciprtion: value,
                        })} />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item mr={3}>
                  <Stack vertical align="center">
                    <Stack.Item mb={2}>
                      Intensity
                    </Stack.Item>
                    <Stack.Item mb={2}>
                      <Tooltip
                        content="Set your objective's intensity level. Check the \
                          tutorial details/examples about each level." >
                        <RoundGauge
                          size={2}
                          value={selectedObjective.intensity}
                          minValue={1}
                          maxValue={5}
                          alertAfter={3.9}
                          format={value => null}
                          position="relative"
                          ranges={{
                            "green": [1, 1.8],
                            "good": [1.8, 2.6],
                            "yellow": [2.6, 3.4],
                            "orange": [3.4, 4.2],
                            "red": [4.2, 5] }} />
                      </Tooltip>
                    </Stack.Item>
                    <Stack.Item>
                      <NumberInput
                        value={selectedObjective.intensity}
                        step={1}
                        minValue={1}
                        maxValue={5}
                        stepPixelSize={15}
                        onDrag={(e, value) => act('set_objective_intensity', {
                          objective_ref: selectedObjective.ref,
                          new_intensity: value,
                        })} />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Stack vertical width="175px">
                    <Stack.Item>
                      Justification
                    </Stack.Item>
                    <Stack.Item>
                      <TextArea
                        height="85px"
                        value={selectedObjective.justification}
                        onInput={(e, value) => act('set_objective_justification', {
                          objective_ref: selectedObjective.ref,
                          new_justification: value,
                        })} />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
              </Stack>
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
