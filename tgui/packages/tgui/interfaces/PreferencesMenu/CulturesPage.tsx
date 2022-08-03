import { Stack, Section, Tooltip, Box, Divider } from '../../components';
import { useBackend } from '../../backend';
import { CultureFeature, PreferencesMenuData } from './data';

export const BackgroundEntry = (props) => {
  const { background, distance, ruler, capital } = props;
  let lang_string: string = '';
  let not_first_iteration: boolean = false;
  for (let language_string in background.additional_langs) {
    if (not_first_iteration) {
      lang_string += ', ';
    } else {
      not_first_iteration = true;
    }
    lang_string += background.additional_langs[language_string];
  }

  return (
    <Stack vertical className={'PreferencesMenu__Cultures__contents'}>
      <Stack.Item>{background.description}</Stack.Item>
      <Stack.Item>{'Economic Power: ' + background.economic_power}</Stack.Item>
      {ifWorking(
        'Language: ' + background.required_lang,
        background.required_lang,
        (val: string) => {
          return val;
        }
      )}
      {ifWorking(
        'Optional Languages: ' + lang_string,
        lang_string,
        (val: string) => {
          return val.length > 0;
        }
      )}
      {ifWorking('Distance: ' + distance, distance, (val: string) => {
        return val;
      })}
      {ifWorking('Ruler: ' + ruler, ruler, (val: string) => {
        return val;
      })}
      {ifWorking('Capital: ' + capital, capital, (val: string) => {
        return val;
      })}
    </Stack>
  );
};

export const ifWorking = (value, val, fnc) => {
  if (fnc(val)) {
    return <Stack.Item>{value}</Stack.Item>;
  } else {
    return '';
  }
};

export const LocationEntry = (props) => {
  const { location } = props;
  return (
    <BackgroundEntry
      background={location}
      distance={location.distance}
      ruler={location.ruler}
      capital={location.capital}
    />
  );
};

export const FeatureEntry = (props: { feature: CultureFeature }) => {
  const { feature } = props;

  return (
    <Tooltip
      position="bottom-end"
      content={
        <Box>
          <Box as="b">{feature.name}</Box>
          <Divider />
          <Box>{feature.description}</Box>
        </Box>
      }>
      <Box class={feature.css_class + ' cultures32x32 ' + feature.icon} />
    </Tooltip>
  );
};

export const CulturesPage = (props, context) => {
  const { data } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack>
      <Stack.Item minWidth="33%">
        <Section title="Cultures">
          <Stack vertical>
            {data.cultures.map((val) => (
              <Stack.Item
                minWidth="33%"
                key={val.name}
                className="PreferencesMenu__Cultures__header">
                <Section title={val.name}>
                  <BackgroundEntry background={val} />
                  <Stack fill justify="right">
                    {val.features.map((val2) => (
                      <Stack.Item key={val2}>
                        <FeatureEntry
                          key={val2}
                          feature={data.features[val2]}
                        />
                      </Stack.Item>
                    ))}
                  </Stack>
                </Section>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="Locations">
          <Stack vertical>
            {data.locations.map((val) => (
              <Stack.Item
                minWidth="33%"
                key={val.name}
                className="PreferencesMenu__Cultures__header">
                <Section title={val.name}>
                  <LocationEntry location={val} />
                  <Stack fill justify="right">
                    {val.features.map((val2) => (
                      <Stack.Item key={val2}>
                        <FeatureEntry
                          key={val2}
                          feature={data.features[val2]}
                        />
                      </Stack.Item>
                    ))}
                  </Stack>
                </Section>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="Factions">
          <Stack vertical>
            {data.factions.map((val) => (
              <Stack.Item
                minWidth="33%"
                key={val.name}
                className="PreferencesMenu__Cultures__header">
                <Section title={val.name}>
                  <BackgroundEntry background={val} />
                  <Stack fill justify="right">
                    {val.features.map((val2) => (
                      <Stack.Item key={val2}>
                        <FeatureEntry
                          key={val2}
                          feature={data.features[val2]}
                        />
                      </Stack.Item>
                    ))}
                  </Stack>
                </Section>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Stack.Item>

      <script>
        {`
        var entries = document.getElementsByTagName('PreferencesMenu__Cultures__header');
        for (entry in entries) {
          entry.onclick = function() {
            entry.style.background_color = "blue";
          }
        }
        `}
      </script>
    </Stack>
  );
};
