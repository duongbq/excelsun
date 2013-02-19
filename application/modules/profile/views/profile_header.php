<?php $current_account = $this->csession->get('logged_user'); ?>
<header>
    <!--            Avatar-->
    <a id="avatar" href="#inline" class="fl avatar" title="Change avatar">
        <?php if (isset($avatar) && !is_null($avatar)): ?>
        <img src="/uploads/avatar/<?php echo $avatar; ?>"/>
        <?php endif; ?>
    </a>
    <!--            Avatar-->
    <!--            Name-->
    <?php echo heading($current_account->first_name . " " . $current_account->last_name, 1); ?>
    <!--            Name-->
    <!--            Role-->
    <?php echo anchor('#', $roles); ?>
    <!--            Role-->
</header>