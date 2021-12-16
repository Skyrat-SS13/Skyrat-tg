import { useBackend } from '../backend';
import { Section, Stack, TextArea, LabeledList, Button, Input } from '../components';
import { Window } from '../layouts';

export const OpposingForcePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    backstory,
    has_objectives,
    objectives = [],
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
                width="66%"
                height="54px"
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
              {objectives.map((objective, index) => (
                <LabeledList
                  key={index}
                  label={objective.title}
                  buttons={(
                    <Button
                      icon="cancel"
                      content="Remove"
                      onClick={() => act('remove_objective', {
                        objective: objective.ref,
                      })} />
                  )}>
                  <LabeledList.Item label="Objective Title">
                    <Input
                      width="40%"
                      value={objective.title}
                      placeholder={objective.title}
                      onInput={(e, value) => act('set_objective_title', {
                        objective: objective.ref,
                        title: value,
                      })} />
                  </LabeledList.Item>
                  <LabeledList.Item label="Objective Description">
                    {objective.description}
                  </LabeledList.Item>
                  <LabeledList.Item label="Objective Justification">
                    {objective.justification}
                  </LabeledList.Item>
                  <LabeledList.Item label="Objective Status">
                    {objective.status}
                  </LabeledList.Item>
                </LabeledList>
              ))}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
