import { useBackend } from '../backend';
import { Button, Input, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const Ambitions = (props, context) => {
  const { data } = useBackend(context);
  const { admin, is_malf } = data;
  const { is_admin } = admin;

  return (
    <Window
      height={300}
      width={400}
      title={"Ambitions Panel"}
      theme={is_malf ? "malfunction" : "syndicate"} >
      {!!is_admin && (
        <AdminPanel />
      )}
      <NarrativePanel />
      <AntagPanel />
      <ObjectivePanel />
    </Window>
  );
};

const AdminPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { admin } = data;
  const { handling, submitted, approved, changes_requested } = admin;
  return (
    <Section title="Admin">
      <p>I don&apos;t do anything yet</p>{/** TODO **/}
    </Section>
  );
};

const ObjectivePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { objectives, intensity, intensities, obj_keys, admin } = data;
  const { antag_types, page } = data;
  const { changes_requested } = admin;

  return (
    <Section title={"Objectives - " + antag_types[page]}
      buttons={
        <Button
          content={antag_types[page]}
          color="blue"
          onClick={() => act("change-antag")} />
      } >
      {
      // TODO
      }
    </Section>
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
            <Input
              width={20}
              value={name}
              placeholder={"Name"}
              onChange={(_, val) => act("name", { name: val })} />
          } />
        <LabeledList.Item
          label={"Backstory"}
          buttons={
            <Input
              width={20}
              value={backstory}
              placeholder={"Backstory"}
              onChange={(_, val) => act("backstory", { backstory: val })} />
          } />
        <LabeledList.Item
          label={"Employer"}
          buttons={
            <Input
              width={20}
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
