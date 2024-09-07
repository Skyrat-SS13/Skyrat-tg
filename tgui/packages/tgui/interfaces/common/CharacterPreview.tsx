import { ByondUi } from '../../components';

<<<<<<< HEAD
export const CharacterPreview = (props: {
  width?: string; // SKYRAT EDIT
  height: string;
  id: string;
}) => {
  // SKYRAT EDIT
  const { width = '220px' } = props;
  // SKYRAT EDIT END
  return (
    <ByondUi
      width={width} // SKYRAT EDIT
=======
export const CharacterPreview = (props: { height: string; id: string }) => {
  return (
    <ByondUi
      width="220px"
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
