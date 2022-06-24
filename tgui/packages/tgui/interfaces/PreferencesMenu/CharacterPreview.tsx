import { ByondUi } from '../../components';

<<<<<<< HEAD

export const CharacterPreview = (props: {
  width?: string, // SKYRAT EDIT
  height: string,
  id: string,
}) => {
  // SKYRAT EDIT
  const {
    width = '220px',
  } = props;
  // SKYRAT EDIT END
  return (<ByondUi
    width={width} // SKYRAT EDIT
    height={props.height}
    params={{
      id: props.id,
      type: "map",
    }}
  />);
=======
export const CharacterPreview = (props: { height: string; id: string }) => {
  return (
    <ByondUi
      width="220px"
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
>>>>>>> 731ab29aa73 (Adds Prettierx - or how I broke TGUI for the nth time (#67935))
};
