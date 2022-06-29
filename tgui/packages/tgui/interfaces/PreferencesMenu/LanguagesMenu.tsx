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
            act('remove_language', { language_name: props.language.name })
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
            act('give_language', { language_name: props.language.name })
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
        <Section title="Available Languages">
          <Stack vertical>
            {data.unselected_languages.map((val) => (
              <UnknownLanguage key={val.icon} language={val} />
            ))}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section
          title={
            'Points: ' +
            data.selected_languages.length +
            '/' +
            data.total_language_points
          }>
          Here, you can purchase languages using a point buy system. Each
          Language is worth 1 point.
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="Known Languages">
          <Stack vertical>
            {data.selected_languages.map((val) => (
              <KnownLanguage key={val.icon} language={val} />
            ))}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
