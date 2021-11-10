import { Button, Section, Dropdown, Stack, Flex } from '../components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

const toggleNames = {
  0: "See Examine Messages",
  1: "See Struggle Messages",
  2: "See Other Vore Messages",
  3: "Devourable",
  4: "Digestable",
  5: "Absorbable",
};
const modeToText = (mode) => {
  switch (mode) {
    case 0:
      return "Hold";
    case 1:
      return "Digest";
    case 2:
      return "Absorb";
    default:
      return mode;
  }
};
const switchNames = {
  "name": "Name",
  "desc": "Description",
  "mode": "Mode",
  "can_taste": "Can Taste",
  "swallow_verb": "Swallow Verb",
};
const stringNames = {
  "digest_messages_prey": "Prey Digest Messages",
  "digest_messages_owner": "Pred Digest Messages",
  "struggle_messages_inside": "Struggle Messages Inside",
  "struggle_messages_outside": "Struggle Messages Outside",
  "examine_messages": "Examine Messages",
};

export const BellyStack = (props, context) => {
  const { act, data } = useBackend(context);
  const { 
    current_belly,
    bellies,
    string_types,
    selected_belly,
    other_belly_types,
  } = data;
  const buttonFromName = (name, index) => {
    return (
      <Flex.Item key={index}>
        <Flex direction="row">
          <Flex.Item>
            <Button
              content={switchNames[name]}
              onClick={() => act('belly_act', { varname: name, belly: selected_belly })}
            />
          </Flex.Item>
          <Flex.Item align="end">
            {modeToText(current_belly[name])}
          </Flex.Item>
        </Flex>
      </Flex.Item>
    );
  };
  return (
    <Section title="Bellies" buttons={(
      <Stack>
        <Stack.Item>
          <Button
            content="Remove Belly"
            color="red"
            disabled={bellies.length <= 1 ? true : false}
            onClick={() => act('remove_belly', { belly: selected_belly })} />
        </Stack.Item>
        <Stack.Item>
          <Dropdown
            options={bellies}
            selected={bellies[selected_belly - 1]}
            onSelected={(value) => act('select_belly', { belly: bellies.indexOf(value) + 1 })} />
        </Stack.Item>
      </Stack>
    )}>
      <Flex direction="column">
        {other_belly_types.map((value, index) => {
          return buttonFromName(value, index);
        })}
      </Flex>
      <Section title="Messages">
        <Flex wrap="wrap">
          {string_types.map((value, index) => (
            <Flex.Item key={index}>
              <Button
                content={stringNames[value]}
                onClick={() => act('belly_act', { varname: value, belly: selected_belly })} />
            </Flex.Item>
          ))}
        </Flex>
      </Section>
      <ContentsStack />
    </Section>
  );
};

export const ContentsStack = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_contents, selected_belly } = data;
  if (has_contents) {
    const { contents, contents_noref } = data;
    return (
      <Section title="Contents" buttons={(
        <Button
          content="Eject All"
          color="red"
          onClick={() => act('eject_all', { belly: selected_belly })} />
      )}>
        <Flex wrap="wrap">
          {contents_noref.map((value, index) => (
            <Flex.Item key={index}>
              <Button
                content={value}
                onClick={() => act('contents_act', { ref: contents[value], belly: selected_belly })} />
            </Flex.Item>
          ))}
        </Flex>
      </Section>
    );
  }
  return null;
};

export const InsideStack = (props, context) => {
  const { act, data } = useBackend(context);
  const in_belly = data["in_belly"];
  if (in_belly) {
    const inside_data = data["inside_data"];
    return (
      <Section title={"Inside of " + inside_data["name"]}>
        <Stack vertical>
          <Stack.Item align="center">
            {inside_data["desc"]}
          </Stack.Item>
          <Stack wrap="wrap">
            {inside_data["contents_noref"].map((value, index) => (
              <Stack.Item key={index}>
                <Button
                  content={value}
                  onClick={() => act('inside_act', {
                    ref: inside_data["contents"][value],
                    belly_in: inside_data["belly_inside"],
                  })} />
              </Stack.Item>
            ))}
          </Stack>
        </Stack>
      </Section>
    );
  }
  return null;
};

export const VorePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    enabled,
    toggles,
    unsaved,
    selected_belly,
    tastes_of,
  } = data;
  return (
    <Window
      title={"Vore Panel"}
      width={420}
      height={510}>
      <Window.Content scrollable>
        <Section
          title={unsaved ? "Save Prefs (Unsaved)" : "Save Prefs"}
          buttons={(
            <Flex>
              <Flex.Item>
                <Button
                  content={"Discard Changes"}
                  color="red"
                  disabled={!unsaved}
                  onClick={() => act('discard_changes', { belly: selected_belly })} />
              </Flex.Item>
              <Flex.Item>
                <Button
                  content={"Save Prefs"}
                  color="red"
                  onClick={() => act('save_prefs')} />
              </Flex.Item>
            </Flex>
          )} />
        <InsideStack />
        <Section
          title="Vore Prefs"
          buttons={(
            <Button
              content={enabled ? "Disable Vore" : "Enable Vore"}
              color={enabled ? "green" : "red"}
              onClick={() => act('toggle_vore', {
                toggle: !enabled,
              })} />
          )} >
          {enabled && (
            <BellyStack />
          )}
          {enabled && (
            <Section title="Toggles and other Prefs">
              <Flex wrap="wrap">
                {toggles.map((val, i) => (
                  <Flex.Item key={i}>
                    <Button
                      content={toggleNames[i]}
                      color={val ? "green" : "red"}
                      onClick={() => act('toggle_act', {
                        pref: i,
                        toggle: !val,
                      })} />
                  </Flex.Item>
                ))}
              </Flex>
              <Section title="Other Prefs">
                <Stack>
                  <Stack.Item>
                    <Button
                      content="Tastes of"
                      onClick={() => act('othervar_act', { varname: "tastes_of" })}
                    />
                  </Stack.Item>
                  <Stack.Item align="end">
                    {tastes_of}
                  </Stack.Item>
                </Stack>
              </Section>
            </Section>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};