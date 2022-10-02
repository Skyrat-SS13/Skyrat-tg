import { Stack, Section, Tooltip, Box, Divider, Button } from '../../components';
import { useBackend } from '../../backend';
import { CultureFeature, PreferencesMenuData } from './data';

const BackgroundEntry = (props) => {
  const { background } = props;
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
      <Stack.Item>{background.description.replace(/< ?br ?\/?>/gi)}</Stack.Item>
      <Stack.Item>
        <b>Economic Power:</b> {background.economic_power}
      </Stack.Item>
      {ifExists(
        <Stack.Item>
          <b>Primary Language:</b> {background.required_lang}
        </Stack.Item>,
        background.required_lang,
        (val: string) => {
          return val;
        }
      )}
      {ifExists(
        <Stack.Item>
          <b>Suggested Languages:</b> {lang_string}
        </Stack.Item>,
        lang_string,
        (val: string) => {
          return val.length > 0;
        }
      )}
      {ifExists(
        <Stack.Item>
          <b>Distance:</b> {background.distance}
        </Stack.Item>,
        background.distance,
        (val: string) => {
          return val;
        }
      )}
      {ifExists(
        <Stack.Item>
          <b>Ruler:</b> {background.ruler}
        </Stack.Item>,
        background.ruler,
        (val: string) => {
          return val;
        }
      )}
      {ifExists(
        <Stack.Item>
          <b>Capital:</b> {background.capital}
        </Stack.Item>,
        background.capital,
        (val: string) => {
          return val;
        }
      )}
    </Stack>
  );
};

const HoverInfo = (text) => {
  return (
    <Button
      icon="question-circle"
      color="transparent"
      tooltip={text}
      tooltipPosition="left"
    />
  );
};

const ifExists = (valueToReturn, val, functionToCheckWith) => {
  if (functionToCheckWith(val)) {
    return <Stack.Item>{valueToReturn}</Stack.Item>;
  } else {
    return '';
  }
};

const FeatureEntry = (props: { feature: CultureFeature }) => {
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

const tryAct = (type, valid, data, context) => {
  if (valid) {
    const { act } = useBackend<PreferencesMenuData>(context);
    act(type, data);
  }
};

const CategoryEntry = (props, context) => {
  const { val, type, parentSelected } = props;
  const { data } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack.Item
      minWidth="33%"
      class={
        val.selected
          ? val.selected === 2
            ? 'PreferencesMenu__Cultures__entry PreferencesMenu__Cultures__selected PreferencesMenu__Cultures__selectedChild'
            : 'PreferencesMenu__Cultures__entry PreferencesMenu__Cultures__selected'
          : 'PreferencesMenu__Cultures__entry'
      }>
      <div
        class={
          'Section ' + val.valid ? '' : 'PreferencesMenu__Cultures__invalid'
        }>
        <div
          class="Section__title"
          className={
            val.valid && !(val.selected === 1)
              ? 'PreferencesMenu__Cultures__pointer'
              : ''
          }
          onClick={() =>
            tryAct(
              type,
              val.valid && !(val.selected === 1),
              { 'culture': val.path },
              context
            )
          }>
          <span
            class="Section__titleText"
            style={val.valid ? '' : 'color: grey'}>
            {val.name}
          </span>
          {val.sub_culture_amount > 0 ? (
            <span className="PreferencesMenu__Cultures__subAmount">
              {'+' + val.sub_culture_amount}
            </span>
          ) : (
            ''
          )}
        </div>
        <div class="Section__rest">
          <div class="Section__content">
            <BackgroundEntry background={val} />
            <Stack fill>
              {val.features.map((val2) => (
                <Stack.Item key={val2}>
                  <FeatureEntry key={val2.name} feature={data.features[val2]} />
                </Stack.Item>
              ))}
            </Stack>
            {parentSelected ? (
              <Stack vertical>
                {val.sub_cultures.map((val2) => (
                  <CategoryEntry key={val2.name} val={val2} type={type} />
                ))}
              </Stack>
            ) : (
              ''
            )}
          </div>
        </div>
      </div>
    </Stack.Item>
  );
};

export const BackgroundsPage = (props, context) => {
  const { data } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack>
      <Stack.Item minWidth="33%">
        <Section
          title={
            (
              <HoverInfo text="These are typically low-impact, save the special backgrounds." />
            ) + 'Cultures'
          }>
          <Stack vertical>
            {data.cultures.map((val) =>
              val.selected ? (
                <CategoryEntry
                  key={val.name}
                  val={val}
                  type="select_culture"
                  parentSelected
                />
              ) : (
                <CategoryEntry key={val.name} val={val} type="select_culture" />
              )
            )}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="Locations">
          <Stack vertical>
            {data.locations.map((val) =>
              val.selected ? (
                <CategoryEntry
                  key={val.name}
                  val={val}
                  type="select_location"
                  parentSelected
                />
              ) : (
                <CategoryEntry
                  key={val.name}
                  val={val}
                  type="select_location"
                />
              )
            )}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="Factions">
          <Stack vertical>
            {data.factions.map((val) =>
              val.selected ? (
                <CategoryEntry
                  key={val.name}
                  val={val}
                  type="select_faction"
                  parentSelected
                />
              ) : (
                <CategoryEntry key={val.name} val={val} type="select_faction" />
              )
            )}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
