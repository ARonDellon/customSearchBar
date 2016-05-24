# customSearBar

A custom SearchBar

/**
 *  get all infomations from this textField.  e.g. text
 */
@property (nonatomic,strong,readonly)kTextField *searchTextField;

/**
 *  search textField property
 */
@property (nonatomic,assign)CGRect searchTextFieldFrame;
@property (nonatomic,assign)CGFloat searchTextFieldCornerRadius;
@property (nonatomic,strong)UIColor *searchTextColor;
@property (nonatomic,strong)UIFont *searchTextFont;
@property (nonatomic,assign)NSTextAlignment searchTextAlignment;


/**
 *  placeHolder property
 */
@property (nonatomic,copy)NSString *placeHolderStr;
@property (nonatomic,strong)UIFont * placeHolderFont;
@property (nonatomic,strong)UIColor *placeHolderTextColor;
@property (nonatomic,assign)NSTextAlignment placeHolderTextAlignment;

@protocol kSearchBarDelegate <NSObject>

/**
 *  called when text in textField changed
 *
 *  @param searchBar  self
 *  @param searchText text
 */
- (void)kSearchBar:(kSearchBar *)searchBar textDidChange:(nonnull NSString *)searchText;

/**
 *  called when return in keyboard clicked
 *
 *  @param searchBar  self
 *  @param searchText text
 */
- (void)kSearchBar:(kSearchBar *)searchBar didClickSearchBtn:(nonnull NSString *)searchText;
