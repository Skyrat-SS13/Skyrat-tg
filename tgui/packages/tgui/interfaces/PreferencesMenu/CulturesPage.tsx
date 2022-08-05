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
    <Stack
      vertical
      className={
        background.selected ? '' : 'PreferencesMenu__Cultures__contents'
      }>
      <Stack.Item>{background.description}</Stack.Item>
      <Stack.Item>{'Economic Power: ' + background.economic_power}</Stack.Item>
      {ifExists(
        'Language: ' + background.required_lang,
        background.required_lang,
        (val: string) => {
          return val;
        }
      )}
      {ifExists(
        'Optional Languages: ' + lang_string,
        lang_string,
        (val: string) => {
          return val.length > 0;
        }
      )}
      {ifExists('Distance: ' + distance, distance, (val: string) => {
        return val;
      })}
      {ifExists('Ruler: ' + ruler, ruler, (val: string) => {
        return val;
      })}
      {ifExists('Capital: ' + capital, capital, (val: string) => {
        return val;
      })}
    </Stack>
  );
};

export const ifExists = (valueToReturn, val, functionToCheckWith) => {
  if (functionToCheckWith(val)) {
    return <Stack.Item>{valueToReturn}</Stack.Item>;
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

export const tryAct = (type, valid, data, context) => {
  if (valid) {
    const { act } = useBackend<PreferencesMenuData>(context);
    act(type, data);
  }
};

export const CategoryEntry = (props, context) => {
  const { val, type } = props;
  const { data } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack.Item
      minWidth="33%"
      key={val.name}
      class={
        val.selected
          ? 'PreferencesMenu__Cultures__selected'
          : val.valid
            ? 'PreferencesMenu__Cultures__pointer'
            : ''
      }>
      <div
        class={
          'Section ' + val.valid ? '' : 'PreferencesMenu__Cultures__invalid'
        }
        onClick={() =>
          tryAct(type, val.valid, { 'culture': val.path }, context)
        }>
        <div class="Section__title">
          <span
            class="Section__titleText"
            style={val.valid ? '' : 'color: grey'}>
            {val.name}
          </span>
        </div>
        <div class="Section__rest">
          <div class="Section__content">
            <LocationEntry location={val} />
            <Stack fill>
              {val.features.map((val2) => (
                <Stack.Item key={val2}>
                  <FeatureEntry key={val2} feature={data.features[val2]} />
                </Stack.Item>
              ))}
            </Stack>
          </div>
        </div>
      </div>
    </Stack.Item>
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
              <CategoryEntry key={val.name} val={val} type="select_culture" />
            ))}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="Locations">
          <Stack vertical>
            {data.locations.map((val) => (
              <CategoryEntry key={val.name} val={val} type="select_location" />
            ))}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="Factions">
          <Stack vertical>
            {data.factions.map((val) => (
              <CategoryEntry key={val.name} val={val} type="select_faction" />
            ))}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
