@if (session('locale') == 'en')
    @include('layouts.en')
@endif

@if (session('locale') == 'bn_BD')
    @include('layouts.bn_BD')
@endif

