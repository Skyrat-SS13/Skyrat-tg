import { Stack, Section, Button, Box } from '../../components';
import { useBackend } from '../../backend';
import { PreferencesMenuData } from './data';

export const KnownLanguage = (props, context) => {
  const { act } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack.Item>
      <Section title={props.language.name}>
        {props.language.description}
        <br />
        <Button
          color="bad"
          onClick={() =>
            act('remove_language', {
              language_name: props.language.name,
              language_category: props.language.category,
            })
          }>
          Forget <Box className={'languages16x16 ' + props.language.icon} />
        </Button>
      </Section>
    </Stack.Item>
  );
};

export const UnknownLanguage = (props, context) => {
  const { act } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack.Item>
      <Section title={props.language.name}>
        {props.language.description}
        <br />
        <Button
          color="good"
          onClick={() =>
            act('give_language', {
              language_name: props.language.name,
              language_category: props.language.category,
            })
          }>
          Learn <Box className={'languages16x16 ' + props.language.icon} />
        </Button>
      </Section>
    </Stack.Item>
  );
};

export const LanguagesPage = (props, context) => {
  const { data } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack>
      <Stack.Item minWidth="33%">
        <Section title="Available Core Languages">
          <Stack vertical>
            {data.unselected_core_languages.map((val) => (
              <UnknownLanguage key={val.icon} language={val} />
            ))}
          </Stack>
        </Section>
        <Section title="Available Race Languages">
          <Stack vertical>
            {data.unselected_race_languages.map((val) => (
              <UnknownLanguage key={val.icon} language={val} />
            ))}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section
          title={
            'Core Points: ' +
            data.selected_core_languages.length +
            '/' +
            data.total_core_language_points +
            ' | Core Points: ' +
            data.selected_race_languages.length +
            '/' +
            data.total_race_language_points
          }>
          Here, you can purchase languages using a point buy system. Each
          Language is worth 1 point.
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="Known Core Languages">
          <Stack vertical>
            {data.selected_core_languages.map((val) => (
              <KnownLanguage key={val.icon} language={val} />
            ))}
          </Stack>
        </Section>
        <Section title="Known Race Languages">
          <Stack vertical>
            {data.selected_race_languages.map((val) => (
              <KnownLanguage key={val.icon} language={val} />
            ))}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
