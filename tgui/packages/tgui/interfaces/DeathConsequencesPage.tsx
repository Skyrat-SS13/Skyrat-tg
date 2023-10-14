import { useBackend } from '../backend';
import { Button, NumberInput, Section, Stack } from '../components';
import { PreferencesMenuData } from './PreferencesMenu/data';

export const DeathConsequencesPage = (props, context) => {
  const { data } = useBackend<DeathConsequenceData>(context);
  return (
    <Stack>
      <Stack.Item maxWidth="99%">
        <Section title="Death consequences config">
          <Stack vertical pt="20px" wrap="wrap">
            {data.dc_preferences.map((val) => (
              <ConfigEntry key={val.typepath} preference={val} />
            ))}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const ConfigEntry = (props, context) => {
  const { act } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack.Item>
      <Section title={props.preference.name}>
        {props.preference.desc}
        <br />

        <Stack>
          <Stack.Item>
            {props.preference.interface_type === 'boolean' && (
              <Button.Checkbox
                name="ad"
                checked={props.preference.value}
                onClick={() =>
                  act('dc_pref_changed', {
                    old_value: props.preference.value,
                    new_value: !props.preference.value,
                    interface_type: props.preference.interface_type,
                    typepath: props.preference.typepath,
                  })
                }
              />
            )}

            {props.preference.interface_type === 'numeric' && (
              <NumberInput
                name="dawd"
                value={props.preference.value}
                maxValue={props.preference.max_value}
                minValue={props.preference.min_value}
                step={props.preference.step}
                stepPixelSize={props.preference.step}
                onChange={(e, value) =>
                  act('dc_pref_changed', {
                    old_value: props.preference.value,
                    new_value: value,
                    interface_type: props.preference.interface_type,
                    typepath: props.preference.typepath,
                  })
                }
              />
            )}
          </Stack.Item>
        </Stack>
      </Section>
    </Stack.Item>
  );
};

export type DeathConsequenceData = {
  dc_preferences: DeathConsequencesPreference[];
};

export type DeathConsequencesPreference = {
  name: string;
  desc: string;
  value: string;
  typepath: string;
  interface_type: string;
  min_value: number;
  max_value: number;
  step: number;
};
