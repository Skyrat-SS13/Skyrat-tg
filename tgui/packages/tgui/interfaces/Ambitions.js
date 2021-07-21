import { useBackend } from '../backend';
import { Input, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const Ambitions = (props, context) => {
  const { data } = useBackend(context);
  const { admin } = data;
  const { is_admin } = admin;

  return (
    <Window>
      {!!is_admin && (
        <AdminPanel />
      )}
      <NarrativePanel />
      <ObjectivePanel />
    </Window>
  );
};

const AdminPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { admin } = data;
  const { handling, submitted, approved, changes_requested } = admin;
  return (
    <p>TODO</p> // TODO
  );
};

const ObjectivePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { objectives, intensity, intensities, obj_keys, admin } = data;
  const { changes_requested } = admin;

  return (
    <p>TODO</p> // TODO
  );
};

const NarrativePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { name, backstory, employer } = data;
  return (
    <Section title="Narrative">
      <LabeledList>
        <LabeledList.Item
          label={"Name"}
          buttons={
            <Input grow
              value={name}
              placeholder={"Name"}
              onChange={(_, val) => act("name", { name: val })} />
          } />
        <LabeledList.Item
          label={"Backstory"}
          buttons={
            <Input grow
              value={backstory}
              placeholder={"Backstory"}
              onChange={(_, val) => act("backstory", { backstory: val })} />
          } />
        <LabeledList.Item
          label={"Name"}
          buttons={
            <Input grow
              value={employer}
              placeholder={"Employer"}
              onChange={(_, val) => act("employer", { employer: val })} />
          } />
      </LabeledList>
    </Section>
  );
};

const AntagPanel = (props, context) => {
  return (
    <p>I&apos;ll do something here eventually!</p> // TODO
  );
};
