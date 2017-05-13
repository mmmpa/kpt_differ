<script>
  import { context } from '../libs/bus';

  module.exports = {
    mixins: [context],
    created () {
      console.log('root created');
    },
  };
</script>
