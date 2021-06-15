import { useBackend } from '../backend';
import { Button, Input, Section } from '../components';
import { ButtonCheckbox } from '../components/Button';
import { Window } from '../layouts';

export const DispatchTicket = (props, context) => {
  const { data, act } = useBackend(context);
  const { tdata, self_ref, submit_allow, emagged } = data;
  const { templateUse, templateName } = tdata;

  return (
    <Window title="Ticket Creation" width={600} height={800}>
      <Section
        title={"Template Settings"}
        buttons={
          <>
            <ButtonCheckbox
              content="Use Template"
              color={templateUse ? "good" : "bad"}
              checked={templateUse}
              onClick={() => act("toggle-template-use", { self_ref: self_ref })} />
            <Button
              content={templateName === "None" ? "Select Template" : templateName}
              color="blue"
              disabled={!templateUse}
              onClick={() => act("template-set", { self_ref: self_ref })} />
            {!!emagged && (
              <>
                <Button
                  content="Spoof Location"
                  color="red"
                  onClick={() => act("spoof-location", { self_ref: self_ref })}
                />
                <Button
                  content="Spoof Creator"
                  color="red"
                  onClick={() => act("spoof-creator", { self_ref: self_ref })}
                />
              </>
            )}
          </>
        } />
      {templateUse && (
        <TicketTemplate />
      ) || (
        <TicketAdvanced />
      )}
      <Section title="Ticket Settings"
        buttons={
          <Button
            content="Submit"
            color="blue"
            disabled={!submit_allow}
            onClick={() => act("ticket-submit", { self_ref: self_ref })} />
        }>
        <>
          <TicketTypes />
          <TicketPriorities />
        </>
      </Section>
      <TicketSuspect />
      <TicketImage />
    </Window>
  );
};

const TicketTypes = (props, context) => {
  const { data, act } = useBackend(context);
  const { tdata, types, self_ref } = data;
  const { type } = tdata;

  return (
    <Section title="Type" buttons={
      <>
        {types.map((t) => (
          <Button
            key={t}
            content={t}
            color={t === type ? "green" : "blue"}
            onClick={() => act("set-ticket-type", { self_ref: self_ref, type: t })}
          />
        ))}
      </>
    } />
  );
};

const TicketPriorities = (props, context) => {
  const { data, act } = useBackend(context);
  const { tdata, priorities, self_ref } = data;
  const { priority } = tdata;

  return (
    <Section title="Priority" buttons={
      <>
        {priorities.map((p) => (
          <Button
            key={p}
            content={p}
            color={priority === p ? "green" : "blue"}
            onClick={() => act("set-ticket-priority", { self_ref: self_ref, priority: p })}
          />
        ))}
      </>
    } />
  );
};

const TicketTemplate = (props, context) => {
  const { data } = useBackend(context);
  const { tdata } = data;
  const { title, extra } = tdata;

  return (
    <>
      <Section title="Title">
        <p>{title}</p>
      </Section>
      <Section title="Details">
        <p>{extra}</p>
      </Section>
    </>);
};

const TicketAdvanced = (props, context) => {
  const { data, act } = useBackend(context);
  const { tdata, self_ref } = data;
  const { title, extra } = tdata;
  return (
    <>
      <Section title="Title">
        <Input
          value={title}
          onChange={(e, value) => act("set-ticket-title", { self_ref: self_ref, title: value })}
        />
      </Section>
      <Section title="Details">
        <Input
          fluid
          value={extra}
          onChange={(e, value) => act("set-ticket-extra", { self_ref: self_ref, extra: value })}
        />
      </Section>
    </>);
};

const TicketSuspect = (props, context) => {
  const { data, act } = useBackend(context);
  const { self_ref, tdata } = data;
  const { suspectName, suspectDesc, suspect } = tdata;

  return (
    <Section title="Suspect Information" buttons={
      <ButtonCheckbox
        content="Has Suspect"
        checked={suspect}
        color={suspect ? "green" : "red"}
        onClick={() => act("ticket-suspect-toggle", { self_ref: self_ref })} />
    }>
      {!!suspect && (
        <>
          <p>Name: <Input fluid value={suspectName} onChange={(e, value) => act("ticket-suspect-name", { self_ref: self_ref, suspectName: value })} /></p>
          <p>Desc: <Input fluid value={suspectDesc} onChange={(e, value) => act("ticket-suspect-desc", { self_ref: self_ref, suspectDesc: value })} /></p>
          <p>Don&apos;t forget you can <b>attach an image!</b></p>
        </>
      )}
    </Section>
  );
};

const TicketImage = (props, context) => {
  const { data, act } = useBackend(context);
  const { tdata, self_ref } = data;
  const { imageAttached } = tdata;

  return (
    <Section
      title="Image Settings"
      buttons={
        <>
          <ButtonCheckbox
            content="Attach Image"
            color={imageAttached ? "good" : "bad"}
            checked={imageAttached}
            onClick={() => act("image-attach", { self_ref: self_ref })} />
          {!!imageAttached && (
            <>
              <Button
                content="Change Image"
                color={"blue"}
                onClick={() => act("image-attach", { self_ref: self_ref })} />
              <Button
                content="View Image"
                color={"blue"}
                onClick={() => act("image-view", { self_ref: self_ref })} />
            </>
          )}
        </>
      }
    />
  );
};
