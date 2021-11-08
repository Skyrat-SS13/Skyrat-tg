import { Button, Section, Stack, Dropdown, Flex } from '../components';
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
  const { current_belly, bellies, string_types, selected_belly } = data;
  const buttonFromName = (name) => {
    return (
      <Stack fill>
        <Stack.Item>
          <Button
            content={switchNames[name]}
            onClick={() => act('belly_act', { varname: name, belly: selected_belly })}
          />
        </Stack.Item>
        <Stack.Item grow>
          {modeToText(current_belly[name])}
        </Stack.Item>
      </Stack>
    );
  };
  return (
    <Section title="Bellies" buttons={(
      <Dropdown
        options={bellies}
        selected={bellies[selected_belly]}
        onSelected={(value) => act('select_belly', { belly: bellies.indexOf(value) + 1 })} />
    )}>
      {buttonFromName("name")}
      {buttonFromName("desc")}
      {buttonFromName("mode")}
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
  );
};

export const VorePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { enabled, toggles, unsaved } = data;
  return (
    <Window
      title={"Vore Panel"}
      width={420}
      height={510}>
      <Window.Content scrollable>
        <Section
          title={unsaved ? "Save Prefs (Unsaved)" : "Save Prefs"}
          buttons={(
            <Button
              content={"Save Prefs"}
              color="red"
              onClick={() => act('save_prefs')} />
          )} />
        <Section
          title="Vore Prefs"
          buttons={(
            <Button
              content={enabled ? "Enable Vore" : "Disable Vore"}
              color={enabled ? "green" : "red"}
              onClick={() => act('toggle_vore', {
                toggle: !enabled,
              })} />
          )} >
          {enabled && (
            <BellyStack />
          )}
          {enabled && (
            <Section title="Toggles">
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
            </Section>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};