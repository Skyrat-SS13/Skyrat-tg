import { Stack, Tooltip, Box, Divider, Button } from '../../components';
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
        background.selected ? '' : 'PreferencesMenu__Backgrounds__contents'
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

const HoverInfo = (props) => {
  return (
    <span style={{ 'float': 'right' }}>
      <Button
        icon="question-circle"
        color="transparent"
        tooltip={props.text}
        tooltipPosition="left"
      />
    </span>
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
      <Box class={feature.css_class + ' backgrounds32x32 ' + feature.icon} />
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
            ? 'PreferencesMenu__Backgrounds__entry PreferencesMenu__Backgrounds__selected PreferencesMenu__Backgrounds__selectedChild'
            : 'PreferencesMenu__Backgrounds__entry PreferencesMenu__Backgrounds__selected'
          : 'PreferencesMenu__Backgrounds__entry'
      }>
      <div
        class={
          'Section ' + val.valid ? '' : 'PreferencesMenu__Backgrounds__invalid'
        }>
        <div
          class="Section__title"
          className={
            val.valid && !(val.selected === 1)
              ? 'PreferencesMenu__Backgrounds__pointer'
              : ''
          }
          onClick={() =>
            tryAct(
              type,
              val.valid && !(val.selected === 1),
              { 'background': val.path },
              context
            )
          }>
          <span
            class="Section__titleText"
            style={val.valid ? '' : 'color: grey'}>
            {val.name}
          </span>
          {val.sub_background_amount > 0 ? (
            <span className="PreferencesMenu__Backgrounds__subAmount">
              {'+' + val.sub_background_amount}
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
                {val.sub_backgrounds.map((val2) => (
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

const TooltipSection = (props) => {
  return (
    <div class="Section">
      <div class="Section__title">
        <span class="Section__titleText">{props.title}</span>
        <HoverInfo text={props.hoverText} />
      </div>
      <div class="Section__rest">
        <div class="Section__content">{props.children}</div>
      </div>
    </div>
  );
};

export const BackgroundsPage = (props, context) => {
  const { data } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack>
      <Stack.Item minWidth="33%">
        <TooltipSection
          title="Origins"
          hoverText="These are typically low-impact, save the special backgrounds.">
          <Stack vertical>
            {data.origins.map((val) =>
              val.selected ? (
                <CategoryEntry
                  key={val.name}
                  val={val}
                  type="select_origin"
                  parentSelected
                />
              ) : (
                <CategoryEntry key={val.name} val={val} type="select_origin" />
              )
            )}
          </Stack>
        </TooltipSection>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <TooltipSection
          title="Social Backgrounds"
          hoverText="Thses are typically low impact.">
          <Stack vertical>
            {data.social_backgrounds.map((val) =>
              val.selected ? (
                <CategoryEntry
                  key={val.name}
                  val={val}
                  type="select_social_background"
                  parentSelected
                />
              ) : (
                <CategoryEntry
                  key={val.name}
                  val={val}
                  type="select_social_background"
                />
              )
            )}
          </Stack>
        </TooltipSection>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <TooltipSection
          title="Employments"
          hoverText="These are typically high-impact. Choose with caution.">
          <Stack vertical>
            {data.employments.map((val) =>
              val.selected ? (
                <CategoryEntry
                  key={val.name}
                  val={val}
                  type="select_employment"
                  parentSelected
                />
              ) : (
                <CategoryEntry
                  key={val.name}
                  val={val}
                  type="select_employment"
                />
              )
            )}
          </Stack>
        </TooltipSection>
      </Stack.Item>
    </Stack>
  );
};
